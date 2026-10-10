#!/usr/bin/env python3

"""
    resman.py
    Part of Time Pilot, the 1982 arcade game remake

    Stefan Wessels, 2024
    This is free and unencumbered software released into the public domain.

    Sample invocations here
    python misc/resman.py -v -f -r 160 -i misc/convert.txt -p misc/palette.txt -o src/tpsprs.r -c src/tpsprsd.h
    python misc/resman.py -r 32 -s "png/font.png LETTER::8:8:1:1:1:1:1:2:1" -p misc/palette.txt -o src/tpsprs.r
    python misc/resman.py -v -f -r 160 -i misc/convert.txt -p misc/palette.txt -o src/tpr.c -a misc/audio.txt -s src/audio_data.c -c src/resids.h
"""
import argparse
import os
import re
import subprocess
import sys
from datetime import datetime
from PIL import Image

# Constants to match sprite.c
DRAW_PIXELS_TOKEN = 2
SKIP_PIXELS_TOKEN = 3
LINE_START_TOKEN  = 1
END_SHAPE_TOKEN   = 0

# Audio resource base ID
AUDIO_BASE_RESID  = 8192

# Keep PNG palette keys unchanged: those keys identify source-art pixels,
# while these targets select display colours.
ARCHIE_SKY_RGB = {15: 0x000063, 16: 0x005963, 17: 0x00655A,
                 18: 0x5A005A, 19: 0x000000}
# Stage 3 is the brighter target; choose the next lighter green-tinted match
# so the two adjacent teal periods remain visually distinct.
ARCHIE_SKY_OVERRIDES = {17: 42}  # RGB 226666

#------------------------------------------------------------------------------
# MARK: encode_image
def append_bytes(buffer, data, num_bytes):
    for i in range(num_bytes):
        buffer.append((data >> (8 * (num_bytes - 1 - i))) & 0xFF)

#------------------------------------------------------------------------------
# MARK: archie_color_distance
def archie_color_distance(a, b):
    dr = ((a >> 16) & 0xFF) - ((b >> 16) & 0xFF)
    dg = ((a >> 8) & 0xFF) - ((b >> 8) & 0xFF)
    db = (a & 0xFF) - (b & 0xFF)
    return dr * dr + dg * dg + db * db

#------------------------------------------------------------------------------
# MARK: archie_expand_nibble_rgb
def archie_expand_nibble_rgb(rgb):
    red = ((rgb >> 20) & 0x0F) * 0x11
    green = ((rgb >> 12) & 0x0F) * 0x11
    blue = ((rgb >> 4) & 0x0F) * 0x11
    return (red << 16) | (green << 8) | blue

#------------------------------------------------------------------------------
# MARK: archie_mode13_rgb_from_pixel
def archie_mode13_rgb_from_pixel(pixel):
    red = ((pixel >> 4) & 1) << 3
    green = ((pixel >> 6) & 1) << 3
    blue = ((pixel >> 7) & 1) << 3

    red |= ((pixel >> 2) & 1) << 2
    green |= ((pixel >> 5) & 1) << 2
    blue |= ((pixel >> 3) & 1) << 2

    red |= ((pixel >> 1) & 1) << 1
    green |= ((pixel >> 1) & 1) << 1
    blue |= ((pixel >> 1) & 1) << 1

    red |= pixel & 1
    green |= pixel & 1
    blue |= pixel & 1

    return ((red * 0x11) << 16) | ((green * 0x11) << 8) | (blue * 0x11)

#------------------------------------------------------------------------------
# MARK: archie_nearest_mode13_pixel
def archie_nearest_mode13_pixel(rgb):
    target = archie_expand_nibble_rgb(rgb)
    best_distance = None
    best_pixel = 0

    for pixel in range(256):
        candidate = archie_mode13_rgb_from_pixel(pixel)
        distance = archie_color_distance(target, candidate)
        if best_distance is None or distance < best_distance:
            best_distance = distance
            best_pixel = pixel
            if distance == 0:
                break

    return best_pixel

#------------------------------------------------------------------------------
# MARK: build_archie_color_map
def build_archie_color_map(logical_colors):
    color_map = list(range(256))

    for logical_color, rgb_hex in logical_colors.items():
        if logical_color < 0 or logical_color > 0xFE:
            continue
        if logical_color in ARCHIE_SKY_RGB:
            target = ARCHIE_SKY_RGB[logical_color]
            color_map[logical_color] = min(range(256), key=lambda pixel:
                archie_color_distance(target, archie_mode13_rgb_from_pixel(pixel)))
            color_map[logical_color] = ARCHIE_SKY_OVERRIDES.get(logical_color, color_map[logical_color])
        else:
            color_map[logical_color] = archie_nearest_mode13_pixel(int(rgb_hex, 16))

    return color_map

#------------------------------------------------------------------------------
# MARK: remap_sprite_data_for_archie
def remap_sprite_data_for_archie(data, color_map):
    remapped = bytearray(data)
    src_ptr = 8
    end_ptr = len(remapped)

    while src_ptr + 4 <= end_ptr:
        token = int.from_bytes(remapped[src_ptr:src_ptr + 4], 'big')
        token_op = token >> 24
        token_data = token & 0x00FFFFFF
        src_ptr += 4

        if token_op == DRAW_PIXELS_TOKEN:
            for i in range(token_data):
                if src_ptr + i >= end_ptr:
                    break
                if remapped[src_ptr + i] != 0xFF:
                    remapped[src_ptr + i] = color_map[remapped[src_ptr + i]]
            src_ptr += token_data
            src_ptr += (4 - (token_data % 4)) % 4
        elif token_op in (SKIP_PIXELS_TOKEN, LINE_START_TOKEN):
            continue
        elif token_op == END_SHAPE_TOKEN:
            break
        else:
            raise ValueError(f"Unexpected sprite token {token_op}")

    return bytes(remapped)

#------------------------------------------------------------------------------
# MARK: sprite_rect_from_data
def sprite_rect_from_data(data):
    return (
        int.from_bytes(data[0:2], 'big'),
        int.from_bytes(data[2:4], 'big'),
        int.from_bytes(data[4:6], 'big'),
        int.from_bytes(data[6:8], 'big'),
    )

#------------------------------------------------------------------------------
# MARK: sprite_words_from_data
def sprite_words_from_data(data):
    words = []
    src_ptr = 8
    end_ptr = len(data)

    while src_ptr + 4 <= end_ptr:
        token = int.from_bytes(data[src_ptr:src_ptr + 4], 'big')
        token_op = token >> 24
        token_data = token & 0x00FFFFFF
        words.append(token)
        src_ptr += 4

        if token_op == DRAW_PIXELS_TOKEN:
            padded_count = token_data + ((4 - (token_data % 4)) % 4)
            chunk_end = src_ptr + padded_count
            while src_ptr < chunk_end:
                chunk = data[src_ptr:src_ptr + 4]
                words.append(
                    chunk[0]
                    | (chunk[1] << 8)
                    | (chunk[2] << 16)
                    | (chunk[3] << 24)
                )
                src_ptr += 4
        elif token_op in (SKIP_PIXELS_TOKEN, LINE_START_TOKEN):
            continue
        elif token_op == END_SHAPE_TOKEN:
            break
        else:
            raise ValueError(f"Unexpected sprite token {token_op}")

    return words

#------------------------------------------------------------------------------
# MARK: convert_color_to_transparent
def convert_color_to_transparent(image, hex_color):
    # Convert HEX color to RGB
    br, bg, bb = tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))
    # Get pixel data
    pixels = image.getdata()
    # Create a new pixel list with transparency applied
    transparent_pixels = [
        (0, 0, 0, 0) if (r, g, b) == (br, bg, bb) else (r, g, b, a)
        for (r, g, b, a) in pixels
    ]
    # Update the image with the new pixel data
    image.putdata(transparent_pixels)
    return image

#------------------------------------------------------------------------------
# MARK: convert_to_indexed
def convert_to_indexed(image, palette, extend_palette):
    image = image.convert('RGB')
    indexed_image = Image.new('P', image.size)

    # Create a mapping from image colors to palette indices
    color_to_index = {tuple(int(color[i:i+2], 16) for i in (0, 2, 4)): idx for color, idx in palette.items()}

    def get_color_index(color):
        if color in color_to_index:
            return color_to_index[color]
        elif extend_palette:
            index = len(color_to_index)
            color_to_index[color] = index
            palette[f'{color[0]:02X}{color[1]:02X}{color[2]:02X}'] = index
            return index
        else:
            raise ValueError(f"Color {color} not in palette and extension not allowed.")

    pixels = list(image.getdata())
    indexed_pixels = [get_color_index(pixel) for pixel in pixels]
    indexed_image.putdata(indexed_pixels)
    return indexed_image

#------------------------------------------------------------------------------
# MARK: crop_images
def crop_images(images, bounding_box):
    min_x, min_y, max_x, max_y = bounding_box
    cropped_images = []
    for image in images:
        cropped_image = image.crop((min_x, min_y, max_x + 1, max_y + 1))
        cropped_images.append(cropped_image)
    return cropped_images
    
#------------------------------------------------------------------------------
# MARK: encode_image
def encode_image(image, transparent_pixel):
    width, height = image.size
    pixels = list(image.getdata())
    shape_data = []

    # Add the image rect
    append_bytes(shape_data, 0, 4)
    append_bytes(shape_data, height, 2)
    append_bytes(shape_data, width, 2)

    for y in range(height):
        line_start = len(shape_data)
        shape_data.extend([0, 0, 0, 0])  # Placeholder for line start token
        draw_run = None
        skip_run = None

        for x in range(width):
            pixel = pixels[y * width + x]
            if pixel == transparent_pixel:
                if draw_run is not None:
                    append_bytes(shape_data, (DRAW_PIXELS_TOKEN << 24) + len(draw_run), 4)
                    shape_data.extend(draw_run)
                    # Pad to a multiple of four bytes
                    padding = (4 - (len(draw_run) % 4)) % 4
                    shape_data.extend([0] * padding)
                    draw_run = None
                if skip_run is not None:
                    skip_run += 1
                else:
                    skip_run = 1
            else:
                if skip_run is not None:
                    append_bytes(shape_data, (SKIP_PIXELS_TOKEN << 24) + skip_run, 4)
                    skip_run = None
                if draw_run is not None:
                    draw_run.append(pixel)
                else:
                    draw_run = [pixel]

        if draw_run is not None:
            # Add a draw_run token
            append_bytes(shape_data, (DRAW_PIXELS_TOKEN << 24) + len(draw_run), 4)
            shape_data.extend(draw_run)
            # Pad to a multiple of four bytes
            padding = (4 - (len(draw_run) % 4)) % 4
            shape_data.extend([0] * padding)

        # Update the line start token with the correct length
        line_start_length = len(shape_data) - line_start - 4
        # Calculate the 4-byte line start value to insert
        value_to_insert = (LINE_START_TOKEN << 24) + line_start_length
        # Replace the 4 placeholder bytes for line start in shape_data with the calculated bytes
        for i in range(4):
            shape_data[line_start + i] = (value_to_insert >> (8 * (3 - i))) & 0xFF

    # Add the end shape token
    append_bytes(shape_data, END_SHAPE_TOKEN << 24, 4)
    return bytes(shape_data)

#------------------------------------------------------------------------------
# MARK: get_minimum_bounding_box
def get_minimum_bounding_box(frames):
    min_x, min_y, max_x, max_y = frames[0].width, frames[0].height, 0, 0
    for frame in frames:
        for y in range(frame.height):
            for x in range(frame.width):
                _, _, _, a = frame.getpixel((x, y))
                if a:
                    if x < min_x:
                        min_x = x
                    if y < min_y:
                        min_y = y
                    if x > max_x:
                        max_x = x
                    if y > max_y:
                        max_y = y
    return min_x, min_y, max_x, max_y

#------------------------------------------------------------------------------
# MARK: load_palette
def load_palette(palette_file):
    palette = {}
    logical_colors = {}
    if palette_file:
        try:
            with open(palette_file, 'r') as file:
                for line in file:
                    line = line.strip()
                    if line and not line.startswith('#'):
                        key, value = line.split(maxsplit=1)
                        value = value.split('#')[0].strip()  # Extract the value before any comments
                        logical_index = int(value)
                        # For source-art conversion, keep the first RGB mapping seen for a color.
                        if key not in palette:
                            palette[key] = logical_index
                        # For Archie remapping, keep the first RGB assigned to a logical color.
                        # This preserves the historical meaning of shared logical indices such as 11.
                        if logical_index not in logical_colors:
                            logical_colors[logical_index] = key
        except Exception as e:
            print(f"Error reading palette file: {e}")
    return palette, logical_colors

#------------------------------------------------------------------------------
# MARK: pad_image
def pad_image(image, pad_value):
    # Get the size of the original image
    width, height = image.size
    # Calculate the new width after padding
    new_width = width + abs(pad_value)
    # Create a new image with the updated width
    new_image = Image.new("RGBA", (new_width, height), (0, 0, 0, 0))
    # Paste the original image onto the new image
    new_image.paste(image)
    return new_image

#------------------------------------------------------------------------------
# MARK: parse_audio_params
def parse_audio_params(params):
    
    audio_defaults = [0, 5512, 1, -1]  # Default parameter values loops, rate, channels, resID
    parsed_params = params.split(':')
    parsed_params.extend([''] * (len(audio_defaults) - len(parsed_params)))  # Extend parsed_params with empty strings
    parsed_params = [int(val) if val else int(audio_defaults[i]) for i, val in enumerate(parsed_params)]
    return parsed_params, audio_defaults

#------------------------------------------------------------------------------
# MARK: parse_image_params
def parse_image_params(params):
    def convert_value(val, default):
        if val == '':
            return default  # Use default if val is an empty string
        try:
            # Attempt to convert to int only if the value should be an int
            return int(val) if isinstance(default, int) else val
        except ValueError:
            return val
    
    defaults = [None, None, 1, 1, 0, 0, 0, 0, 0, 1, -1]  # Default parameter values
    parsed_params = params.split(':')
    parsed_params.extend([''] * (len(defaults) - len(parsed_params)))  # Extend parsed_params with empty strings
    parsed_params = [convert_value(val, defaults[i]) for i, val in enumerate(parsed_params)]
    return parsed_params

#------------------------------------------------------------------------------
# MARK: convert_audio_to_blob
def convert_audio_to_blob(file_name, loops, rate, channels):
    output = []
    
    # Use ffmpeg to convert the audio to 8-bit unsigned PCM
    command = [
        'ffmpeg', '-i', file_name, '-ar', str(rate), '-ac', str(channels),
        '-filter:a', 'loudnorm', '-f', 'u8', '-acodec', 'pcm_u8', 'pipe:1'
    ]
    
    # Run the command and capture the output
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
    
    # Convert the raw bytes to a list of integers
    audio_data = list(result.stdout)
    padding_needed = (16 - len(audio_data) % 16)  # Need an addtional % 16 to not get 16, but I always want padding
    audio_data.extend([128] * padding_needed)  # Extend the list with the required number of pad bytes

    # Add the appropriate header to the buffer
    append_bytes(output, 0x0001, 2)                          #  0 format type
    append_bytes(output, 0x0001, 2)                          #  2 number of data types
    append_bytes(output, 0x0005, 2)                          #  4 sampled-sound data
    append_bytes(output, 0x00000080, 4)                      #  6 initialization option: initMono
    append_bytes(output, 0x0001, 2)                          # 10 number of sound commands that follow (1)
    append_bytes(output, 0x8051, 2)                          # 12 command 1--bufferCmd
    append_bytes(output, 0x0000, 2)                          # 14 param1 = 0
    append_bytes(output, 0x00000014, 4)                      # 16 param2 = offset to sound header (20 bytes)
    append_bytes(output, 0x00000000, 4)                      # 20 pointer to data (it follows immediately)
    append_bytes(output, len(audio_data), 4)                 # 24 number of bytes in sample (3000 bytes)
    append_bytes(output, int(rate * (1 << 16)), 4)           # 28 sampling rate of this sound (22 kHz)
    append_bytes(output, 0x00000000, 4)                      # 32 starting of the sample's loop point
    append_bytes(output, len(audio_data) if loops else 0, 4) # 36 ending of the sample's loop point
    append_bytes(output, 0x00, 1)                            # 40 standard sample encoding
    append_bytes(output, 60, 1)                              # 41 baseFrequency at which sample was taken
    
    # Append the audio data to the buffer
    output.extend(audio_data)
    
    return output

#------------------------------------------------------------------------------
# MARK: convert_audio_to_linear_pcm
def convert_audio_to_linear_pcm(file_name, rate, channels):
    command = [
        'ffmpeg', '-i', file_name, '-ar', str(rate), '-ac', str(channels),
        '-filter:a', 'loudnorm', '-f', 's8', '-acodec', 'pcm_s8', 'pipe:1'
    ]

    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
    return bytes(result.stdout)

#------------------------------------------------------------------------------
# MARK: audio_samples_from_pcm
def audio_samples_from_pcm(linear_pcm):
    samples = []
    for byte in linear_pcm:
        samples.append(byte - 256 if byte > 127 else byte)
    return samples

#------------------------------------------------------------------------------
# MARK: save_audio_samples_c
def save_audio_samples_c(file, name, samples):
    file.write(f"static const int8_t {name.lower()}_data[] = {{\n")
    for i in range(0, len(samples), 16):
        chunk = samples[i:i + 16]
        file.write(f"    {', '.join(str(sample) for sample in chunk)},\n")
    file.write("};\n\n")

#------------------------------------------------------------------------------
# MARK: write_audio_c_output
def write_audio_c_output(output_file, audio_resources):
    header_file = os.path.splitext(output_file)[0] + '.h'
    header_name = os.path.basename(header_file)

    with open(header_file, 'w') as header:
        header.write(f"// {date_time_str}")
        header.write("#pragma once\n\n")
        header.write("#include <stdint.h>\n\n")
        header.write("typedef struct {\n")
        header.write("    const int8_t *data;\n")
        header.write("    uint32_t length;\n")
        header.write("    uint32_t rate;\n")
        header.write("    uint8_t loop;\n")
        header.write("} tpaAudioSample;\n\n")
        header.write("extern const tpaAudioSample tpaAudioSamples[];\n")
        header.write("extern const uint32_t tpaAudioSampleCount;\n")

    with open(output_file, 'w') as resource_file:
        resource_file.write(f"// {date_time_str}")
        resource_file.write("#include <stdint.h>\n\n")
        resource_file.write(f'#include "{header_name}"\n\n')

        for resource_name, _, _, _, audio_data in audio_resources:
            save_audio_samples_c(resource_file, resource_name, audio_data)

        resource_file.write("const tpaAudioSample tpaAudioSamples[] = {\n")
        for resource_name, _, loops, rate, audio_data in audio_resources:
            resource_file.write(
                f"    {{{resource_name.lower()}_data, {len(audio_data)}U, {rate}U, {1 if loops else 0}U}},\n"
            )
        resource_file.write("};\n\n")
        resource_file.write("const uint32_t tpaAudioSampleCount = sizeof(tpaAudioSamples) / sizeof(tpaAudioSamples[0]);\n")

#------------------------------------------------------------------------------
# MARK: process_images
def process_audio(args):
    audio_lines = []
    with open(args.audio_file, 'r') as f:
        audio_lines = f.readlines()

    resource_list = []
    audio_resources = []
    output_is_c = args.sound_resource.lower().endswith('.c')
    resource_id = AUDIO_BASE_RESID

    for line in audio_lines:
        line = line.split('#', 1)[0].strip()
        if not line:
            continue

        parts = line.split()
        file_name = parts[0]
        output_name = os.path.splitext(os.path.basename(file_name))[0].upper()
        params = parts[1] if len(parts) > 1 else ''

        parsed_params, defaults = parse_audio_params(params)
        loops, rate, channels, resID = parsed_params

        if resID != -1:
            resource_id = resID

        if args.verbose:
            print("{:16} {}{}".format(
                output_name, resource_id,
                ''.join(" {}".format(var_name) for var_name, var_value, default_value in [
                    (f"loop={loops}", loops, defaults[0]),
                    (f'rate={rate}', rate, defaults[1]),
                    (f'chan={channels}', channels, defaults[2]),
                    (f'res ={resID}', resID, defaults[3])] if var_value != default_value)))

        if output_is_c:
            audio_data = audio_samples_from_pcm(convert_audio_to_linear_pcm(file_name, rate, channels))
            audio_resources.append((output_name, resource_id, loops, rate, audio_data))
        else:
            audio_blob = convert_audio_to_blob(file_name, loops, rate, channels)
            audio_resources.append((output_name, resource_id, loops, rate, audio_blob))

        resource_list.append([f"{output_name}", resource_id])
        resource_id += 1

    if output_is_c:
        write_audio_c_output(args.sound_resource, audio_resources)
    else:
        with open(args.sound_resource, 'w') as resource_file:
            py_date_time_str = "// " + date_time_str
            resource_file.write(py_date_time_str)
            for output_name, resource_id, _, _, audio_blob in audio_resources:
                save_bytes_data(resource_file, output_name, 'snd ', resource_id, audio_blob)

    if(args.code_file is not None):
        save_to_code_file(args.code_file, resource_list, "RAU_", 0)
        save_to_code_file(args.code_file, resource_list, "AUDIO_", AUDIO_BASE_RESID)

#------------------------------------------------------------------------------
# MARK: process_images
def process_images(image_lines, palette, args):
    def parse_output_name(output_name):
        # Initialize defaults
        extracted_num = 0
        format_string = output_name
        is_formatting_string = False

        # Regular expression to match %c followed by (number)
        match = re.search(r'%c\((-?\d+)\)', output_name)

        if match:
            extracted_num = int(match.group(1))
            format_string = re.sub(r'\(-?\d+\)', '', output_name)
            is_formatting_string = True
        else:
            extracted_num = 0
            format_string = output_name

        return is_formatting_string, format_string, extracted_num

    output_is_c = args.output_file.lower().endswith('.c')
    archie_color_map = build_archie_color_map(args.logical_colors) if output_is_c else None
    resource_list = []
    pallet_number = 0
    verbose_name = ""
    sprite_resources = []
    prop_frames = []

    # Process each line of the images file read in
    for line in image_lines:
        # Split the line at the first '#' and take the part before it
        line = line.split('#', 1)[0].strip()
        # Check if there's anything left after stripping
        if not line:
            continue

        # Split file name and parameters
        parts = line.split()
        file_name = parts[0]
        format_string = ''
        params = parts[1] if len(parts) > 1 else ''  # Extract parameters if provided
        
        # Parse parameters
        output_name, background_color, frame_width, frame_height, fixed_width, offset_x, offset_y, pad_x, pad_y, scale_factor, prop_background = parse_image_params(params)
        if output_name is None:
            output_name = os.path.splitext(os.path.basename(file_name))[0].upper()
        else:
            is_formatting_string, format_string, output_adjust = parse_output_name(output_name)
            if not is_formatting_string:
                output_name = format_string
                format_string = ''
        
        # Open image
        image = Image.open(file_name)
        # Convert the image to RGBA mode (if not already)
        image = image.convert("RGBA")

        if background_color is not None:
            # Make the background color pixels transparent
            image = convert_color_to_transparent(image, background_color)
        width, height = image.size
        
        # Handle fixed width
        if fixed_width != 1:
            frame_width = width // frame_width
            frame_height = height // frame_height
        
        # Handle offsets
        offset_x = int(offset_x) if offset_x else 0
        offset_y = int(offset_y) if offset_y else 0
        
        # Handle padding
        pad_x = int(pad_x) if pad_x else 0
        pad_y = int(pad_y) if pad_y else 0

        # Slice image and save frames
        frames = []
        for y in range(offset_y, height, frame_height + pad_y):
            for x in range(offset_x, width, frame_width + pad_x):
                frame = image.crop((x, y, x + frame_width, y + frame_height))
                frames.append(frame)

        if args.frame:
            # Clip all frames to a frame rectangle that fits the contents of all frames
            bounding_box = get_minimum_bounding_box(frames)
            frames = crop_images(frames, bounding_box)

        num_frames = len(frames)
        frame_counter = 0
        for frame in frames:
            # Scale the frame if scale_factor not 1
            if scale_factor != 1:
                # Calculate the new size of the frame
                new_frame_size = (frame.width * scale_factor, frame.height * scale_factor)
                # Now scale the frame with NEAREST filter
                frame = frame.resize(new_frame_size, Image.NEAREST)

            # if the frame is not long-aligned, make the frame divisible by 4
            if frame.width % 4:
                frame = pad_image(frame, 4 - (frame.width % 4))

            # Go from RGBA to P (indexed using the palette)
            frame = convert_to_indexed(frame, palette, args.extend)

            if args.verbose:
                if output_name != verbose_name:
                    verbose_name = output_name
                    print("{:16} w:{:3} h:{:3}{}".format(
                        output_name, frame.width, frame.height,
                        ''.join(" {}".format(var_name, var_value) for var_name, var_value in [
                            (f"bg={background_color}", background_color),
                            (f'ox={offset_x}', offset_x), 
                            (f'oy={offset_y}', offset_y), 
                            (f'px={pad_x}', pad_x), 
                            (f'py={pad_y}', pad_y)] if var_value != 0 and var_value is not None)))

            if args.display:
                # Get the pixel data as a list
                pixels = list(frame.getdata())
                # Iterate over blocks of size `frame_width` in the pixels list
                for i in range(0, len(pixels), frame.width):
                    # Construct the hex string for each block
                    hex_string = ''.join(
                        "{:02X}".format(pixels[i + j]) if pixels[i + j] != args.transparent else "  "
                        for j in range(frame.width)
                    )
                    # Print the constructed string for this block
                    print(hex_string)
                print("")

            original_frame = frame
            if prop_background >= 0:
                frame = frame.copy()
                frame.putdata([{13: 14, 14: prop_background}.get(pixel, pixel)
                               for pixel in original_frame.getdata()])

            # Encode the frame
            encoded_data = encode_image(frame, args.transparent)
            if output_is_c:
                encoded_data = remap_sprite_data_for_archie(encoded_data, archie_color_map)

            # Each frame gets a unique name
            if format_string:
                output_adjusted = args.resource_number + output_adjust
                frame_name = format_string % output_adjusted
                for char in frame_name:
                    ascii_value = ord(char)
                    if not (48 <= ascii_value <= 57 or 65 <= ascii_value <= 90 or 95 == ascii_value):
                        frame_name = format_string.replace("%c", "") + f"{output_adjusted}"
                        break
            else:
                frame_name = f"{output_name}{frame_counter}" if num_frames > 1 else output_name

            if prop_background >= 0:
                prop_frames.append((frame_name, original_frame, prop_background))
            sprite_rect = sprite_rect_from_data(encoded_data)
            sprite_words = sprite_words_from_data(encoded_data) if output_is_c else None
            sprite_resources.append((frame_name, args.resource_number, sprite_rect, sprite_words, encoded_data))
            resource_list.append([f"{frame_name}", args.resource_number])

            # Next frame has next number, both resource and counter
            args.resource_number += 1
            frame_counter += 1

    # Append variants after base resources so existing resource IDs stay stable.
    for frame_name, frame, background in prop_frames:
        alternate = frame.copy()
        alternate.putdata([{13: background, 14: 14}.get(pixel, pixel)
                           for pixel in frame.getdata()])
        encoded = encode_image(alternate, args.transparent)
        if output_is_c:
            encoded = remap_sprite_data_for_archie(encoded, archie_color_map)
        name = frame_name + '_PROP'
        sprite_resources.append((name, args.resource_number, sprite_rect_from_data(encoded),
                                 sprite_words_from_data(encoded) if output_is_c else None, encoded))
        resource_list.append([name, args.resource_number])
        args.resource_number += 1

    if output_is_c:
        write_sprite_c_output(
            args.output_file,
            [(frame_name, resource_number, sprite_rect, sprite_words)
             for frame_name, resource_number, sprite_rect, sprite_words, _ in sprite_resources]
        )
    else:
        with open(args.output_file, 'w') as resource_file:
            # Write a file header
            py_date_time_str = "// " + date_time_str
            resource_file.write(py_date_time_str)

            for frame_name, resource_number, _, _, encoded_data in sprite_resources:
                save_bytes_data(resource_file, frame_name, 'Sprt', resource_number, encoded_data)

            # Save the color palette (unique by index) to the output file
            save_resource_palette(resource_file, palette, args.resource_clut_id+pallet_number)

    resource_list.append([f"CLUT{pallet_number}", args.resource_clut_id+pallet_number])
    pallet_number += 1

    if args.code_file:
        save_to_code_file(args.code_file, resource_list, 'RID_', 0)
        save_to_code_file(args.code_file, resource_list, 'SID_', resource_list[0][1])

    return palette
        
#------------------------------------------------------------------------------
# Function to save encoded data to output file
# MARK: save_bytes_data
def save_bytes_data(file, name, res_id, res_num, data):
    try:
        # Process data in chunks of 16 bytes (8 words)
        length = len(data)
        # Ensure data is a bytes-like object
        if length % 2 != 0:
            raise ValueError("Data must be 16-bits.")
        file.write(f"data '{res_id}' ({res_num}, \"{name}\") {{\n")
        for i in range(0, length, 16):
            # Start the line string with the desired prefix
            line_list = ["    $\""]
            end_of_data = min(i + 16, length)
            # Process each pair of bytes in the current chunk
            for j in range(i, end_of_data, 2):
                # Combine two bytes to form a word
                word = (data[j] << 8) | data[j + 1]
                # Append the formatted word to the line list
                line_list.append(f"{word:04X}")
            line_list.append("\"\n")
            # Join the words and write the line to the file
            file.write(' '.join(line_list))
        file.write("};\n\n")
                       
    except Exception as e:
        print(f"Error saving encoded data: {e}")

#------------------------------------------------------------------------------
# Function to save encoded sprite words to a C source file
# MARK: save_sprite_words_c
def save_sprite_words_c(file, name, words):
    file.write(f"static const uint32_t {name.lower()}[] = {{\n")
    for i in range(0, len(words), 8):
        chunk = words[i:i + 8]
        hex_words = ', '.join(f"0x{word:08X}U" for word in chunk)
        file.write(f"    {hex_words},\n")
    file.write("};\n\n")

#------------------------------------------------------------------------------
# MARK: write_c_header
def write_c_header(file):
    file.write(f"// {date_time_str}")
    file.write("#include <stdint.h>\n\n")
    file.write('#include "tpr.h"\n\n')

#------------------------------------------------------------------------------
# MARK: write_sprite_c_output
def write_sprite_c_output(output_file, sprite_resources):
    with open(output_file, 'w') as resource_file:
        write_c_header(resource_file)

        for resource_name, _, _, sprite_words in sprite_resources:
            save_sprite_words_c(resource_file, resource_name, sprite_words)

        resource_file.write("const uint16_t tprSpriteRects[][4] = {\n")
        for _, _, sprite_rect, _ in sprite_resources:
            resource_file.write(
                f"    {{{sprite_rect[0]}U, {sprite_rect[1]}U, {sprite_rect[2]}U, {sprite_rect[3]}U}},\n"
            )
        resource_file.write("};\n\n")

        resource_file.write("const uint32_t *const tprSpriteData[] = {\n")
        for resource_name, _, _, _ in sprite_resources:
            resource_file.write(f"    {resource_name.lower()},\n")
        resource_file.write("};\n\n")

        resource_file.write("const uint32_t tprSpriteCount = sizeof(tprSpriteData) / sizeof(tprSpriteData[0]);\n")

#------------------------------------------------------------------------------
# Function to save the palette to a file
# MARK: save_palette
def save_palette(palette, palette_file):
    try:
        with open(palette_file, 'w') as file:
            # Write a file header
            py_date_time_str = "# " + date_time_str
            file.write(py_date_time_str)
            for color in palette:
                file.write(f"{color} {palette[color]}\n")
    except Exception as e:
        print(f"Error saving palette: {e}")

#------------------------------------------------------------------------------
# MARK: save_resource_palette
def save_resource_palette(file, palette, res_id):
    palette_data = []
    # Use a set to track unique indices
    used_indices = set()
    # Sort the palette dictionary items by the palette index (value)
    sorted_palette = sorted(palette.items(), key=lambda item: item[1])
    # Header
    append_bytes(palette_data, 0, 4)
    append_bytes(palette_data, 0x8000, 2)
    append_bytes(palette_data, 0, 2)
    # Iterate over the sorted items
    for color, index in sorted_palette:
        if index not in used_indices:
            # If the index is unique, write it to the file
            # file.write(f"{color} {index}\n")
            r, g, b = tuple(int(color[i:i+2], 16) for i in (0, 2, 4))
            append_bytes(palette_data, 0x8000, 2)
            r = (r << 8) | r
            g = (g << 8) | g
            b = (b << 8) | b
            append_bytes(palette_data, r, 2)
            append_bytes(palette_data, g, 2)
            append_bytes(palette_data, b, 2)
            # Mark this index as used
            used_indices.add(index)
        else:
            # If the index is already used, print the dropped color
            print(f"Dropping color {color} with duplicate index {index}")
    # Update header with the size
    palette_data[6] = int(len(used_indices) / 256)
    palette_data[7] = len(used_indices) % 256
    save_bytes_data(file, 'palette', 'clut', res_id, palette_data)

#------------------------------------------------------------------------------
# MARK: save_to_code_file
def save_to_code_file(code_file, resource_list, prefix, map_to_array):
    # Dictionary to hold the resources from the file and the current list
    resource_dict = {}

    # If the file exists, read its contents
    if os.path.exists(code_file):
        with open(code_file, 'r') as f:
            for line in f:
                # only interested in "C" code lines
                if line.startswith(f"#define "):
                    # Not interested in lines for the prfix under update
                    if not line.startswith(f"#define {prefix}"):
                        parts = line.split()
                        if len(parts) > 1:
                            name, id_number = parts[1].strip(), parts[2].strip()
                            resource_dict[name] = int(id_number)

    # Update the dictionary with the current resource list
    for name, resource_number in resource_list:
        resource_dict[f"{prefix}{name}"] = resource_number - map_to_array

    # Calculate the appropriate width for alignment based on both file and new entries
    max_width = 1 + max(len(name) for name in resource_dict.keys())
    max_width += (8 - (max_width % 4))

    # Write the sorted resource list back to the file
    with open(code_file, 'w') as resource_code_file:
        c_date_time_str = "// " + date_time_str
        resource_code_file.write(c_date_time_str)
        resource_code_file.write("#pragma once\n")

        # set an empty prefix so a blank line can go in when the prefix changes
        prefix = ''

        # Write the updated resource list entries with the given prefix
        for name, id_number in resource_dict.items():
            line_prefix = name[:name.find("_") + 1]
            if line_prefix != prefix:
                prefix = line_prefix
                resource_code_file.write("\n");
            resource_code_file.write(f"#define {name:<{max_width}}{id_number}\n")

#------------------------------------------------------------------------------
# MARK: set_transparent_index
def set_transparent_index(background, palette):
    # Regular expression to match a valid hex color (3 to 6 hex digits, optional 0x prefix)
    hex_pattern = r'^(0x)?[0-9A-Fa-f]{6}$'
    match = re.match(hex_pattern, background)
    try:
        if match:
            # Strip the optional '0x' prefix if present
            hex_color = match.group().lstrip('0x').upper()
            # Attempt to get the index from the palette, using None as a default if not found
            transparent_index = palette.get(hex_color)
            if transparent_index is None:
                raise ValueError
        else:
            if background.startswith("0x"):
                # Convert hexadecimal string to integer
                transparent_index = int(background, 16)
            else:
                # Convert decimal string to integer
                transparent_index = int(background)
    except ValueError:
        print(f"Error: Hex background color {background} is not in the palette.")
        transparent_index = None
    return transparent_index

#------------------------------------------------------------------------------
# MARK: main
def main():
    global date_time_str

    parser = argparse.ArgumentParser(description="Process images and encode them into sprites.")
    parser.add_argument('-a', '--audio-file', help="Input file listing audio files to convert and encode.")
    parser.add_argument('-c', '--code-file', help="Output code file to map resource IDs to names.")
    parser.add_argument('-d', '--display', action='store_true', help="Show the image frames as they are processed.")
    parser.add_argument('-e', '--extend', action='store_true', help="Extend the palette with new colors.")
    parser.add_argument('-f', '--frame', action='store_true', help="Clip frames to smallest rect to encompass all frame.")
    parser.add_argument('-i', '--images-file', help="Input file listing images to be encoded.")
    parser.add_argument('-l', '--resource-clut-id', type=int, default=128, help="Number at which to start the clut (palette) resources.")
    parser.add_argument('-o', '--output-file', help="Output resource file of encoded images, in text.")
    parser.add_argument('-p', '--palette', help="Input palette file.")
    parser.add_argument('-r', '--resource-number', type=int, default=128, help="Number at which to start the image resources.")
    parser.add_argument('-s', '--sound-resource', help="Output file into which audio data is written as snd resources.")
    parser.add_argument('-t', '--transparent', help="Set the transparent color or index from input palette.")
    parser.add_argument('-u', '--image', help="Input file name of image to encode.")
    parser.add_argument('-v', '--verbose', action='store_true', help="Show progress and stats.")
    parser.add_argument('-w', '--write-palette', help="Write the palette to a file (Use with --extend).")
    parser.add_argument('images-file', nargs='?', help="Input file listing images to be encoded.")
    args = parser.parse_args()

    if args.output_file and not (args.images_file or args.image):
        parser.error("At least one of -i or -u must be specified with -o")

    if args.audio_file and not args.sound_resource:
        parser.error("With -a, -s must also be specified.")

    if not args.output_file and not args.audio_file:
        parser.error("Something to process must be specified (-i, -u, -a or all of these)")

    # Get the current date and time
    now = datetime.now()

    # Format the date and time as a string
    date_time_str = now.strftime("This file was generated by resman.py on %Y-%m-%d at %H:%M:%S\n\n")
    args.logical_colors = {}

    if args.output_file:
        # Read input file
        image_lines = []
        if args.images_file:
            with open(args.images_file, 'r') as f:
                image_lines = f.readlines()

        # If a single image was also specified, add it to the list
        if args.image:
            image_lines.append(args.image)

        # Load or init the palette
        if args.palette:
            palette, logical_colors = load_palette(args.palette) if args.palette else ({}, {})
            args.logical_colors = logical_colors
            # set a proper index for args.transparent if a color was provided
            args.transparent = set_transparent_index(args.transparent, palette) if args.transparent else 0
            if args.transparent is None:
                print(f"Color {args.transparent} is not in the palette")
                return

        # Process all the images, and get a palette back (if -e was specified it may have been updated)
        palette = process_images(image_lines, palette, args)

        if args.write_palette:
            # Save the palette in input format
            save_palette(palette, args.write_palette)

    if args.sound_resource:
        process_audio(args)

if __name__ == '__main__':
    main()
