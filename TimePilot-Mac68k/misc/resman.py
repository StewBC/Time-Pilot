#!/usr/bin/env python3

"""
    resman.py
    Part of Time Pilot, the 1982 arcade game remake

    Stefan Wessels, 2024
    This is free and unencumbered software released into the public domain.

    Sample invocations here
    python misc/resman.py -v -f -r 160 -i misc/convert.txt -p misc/palette.txt -o src/tpsprs.r -c src/tpsprsd.h
    python misc/resman.py -r 32 -s "png/font.png LETTER::8:8:1:1:1:1:1:2:1" -p misc/palette.txt -o src/tpsprs.r
    python misc/resman.py -v -f -r 160 -i misc/convert.txt -p misc/palette.txt -o src/tpr.r -a misc/audio.txt -s src/audio.r -c src/resids.h
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

#------------------------------------------------------------------------------
# MARK: encode_image
def append_bytes(buffer, data, num_bytes):
    for i in range(num_bytes):
        buffer.append((data >> (8 * (num_bytes - 1 - i))) & 0xFF)

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
    if palette_file:
        try:
            with open(palette_file, 'r') as file:
                for line in file:
                    line = line.strip()
                    if line and not line.startswith('#'):
                        key, value = line.split(maxsplit=1)
                        value = value.split('#')[0].strip()  # Extract the value before any comments
                        palette[key] = int(value)
        except Exception as e:
            print(f"Error reading palette file: {e}")
    return palette

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
    
    audio_defaults = [0, 11025, 1, -1]  # Default parameter values loops, rate, channels, resID
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
    
    defaults = [None, None, 1, 1, 0, 0, 0, 0, 0, 1]  # Default parameter values
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
# MARK: process_images
def process_audio(args):
    audio_lines = []
    with open(args.audio_file, 'r') as f:
        audio_lines = f.readlines()

        with open(args.sound_resource, 'w') as resource_file:

            # Write a file header
            py_date_time_str = "// " + date_time_str
            resource_file.write(py_date_time_str)

            # a list of resouce (sprite) names with their respective IDs
            resource_list = []
            verbose_name = ""
            resource_id = AUDIO_BASE_RESID

            # Process each line of the images file read in
            for line in audio_lines:
                # Split the line at the first '#' and take the part before it
                line = line.split('#', 1)[0].strip()
                # Check if there's anything left after stripping
                if not line:
                    continue

                # Split file name and parameters
                parts = line.split()
                file_name = parts[0]
                output_name = os.path.splitext(os.path.basename(file_name))[0].upper()
                params = parts[1] if len(parts) > 1 else ''  # Extract parameters if provided
                
                # Parse parameters
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

                # Convert the audio to a blob
                audio_blob = convert_audio_to_blob(file_name, loops, rate, channels)
                
                # Write the blob to the resource file
                save_bytes_data(resource_file, output_name, 'snd ', resource_id, audio_blob)

                # Add the name to the "C" resource list
                resource_list.append([f"{output_name}", resource_id])

                # next resID
                resource_id += 1

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

        return is_formatting_string, format_string, extracted_num    # Open the output file
    
    with open(args.output_file, 'w') as resource_file:

        # Write a file header
        py_date_time_str = "// " + date_time_str
        resource_file.write(py_date_time_str)

        # a list of resouce (sprite) names with their respective IDs
        resource_list = []
        pallet_number = 0
        verbose_name = ""

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
            output_name, background_color, frame_width, frame_height, fixed_width, offset_x, offset_y, pad_x, pad_y, scale_factor  = parse_image_params(params)
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

                # Encode the frame
                encoded_data = encode_image(frame, args.transparent)

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

                # Save encoded data to output file
                save_bytes_data(resource_file, frame_name, 'Sprt', args.resource_number, encoded_data)
                resource_list.append([f"{frame_name}", args.resource_number])

                # Next frame has next number, both resource and counter
                args.resource_number += 1
                frame_counter += 1

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
            palette = load_palette(args.palette) if args.palette else {}
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
