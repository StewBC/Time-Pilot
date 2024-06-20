# mkspr.py by Stefan Wessels, Feb 2024
# python .\misc\mkspr.py .\misc\convert.txt .\misc\palette.txt gif src/sprites [verbose level 1 or 2]
import math, os, re, subprocess, sys
from PIL import Image

#------------------------------------------------------------------------------
banks_of_sprites = {}

#------------------------------------------------------------------------------
# MARK: consolidate_sprite_banks
def consolidate_sprite_banks(output_dir, sprites_dir):
    print("Consolidating sprite banks")
    src_footer = "\nTHISISAFORMATTINGLABEL  ANOP\n                        END\n"
    dat_footer = "\n                        END\n"
    for bank, file_names in banks_of_sprites.items():
        bankpath = os.path.join(sprites_dir, "SPR"+bank) + ".asm"
        with open(bankpath, 'w') as bank_file:  # Open the bank file in append mode
            header = f"                    MCOPY  {sprites_dir}/SPR{bank}.mac\n\nSPR{bank.ljust(17)}START  {bank}\n\n                    USING  VARIABLES\n\n"
            bank_file.write(header)
            for file_name in file_names:
                file_name = os.path.splitext(file_name)[0] + '.txt'
                filepath = os.path.join(output_dir, file_name)
                with open(filepath, 'r') as sprite_file:
                    bank_file.write(sprite_file.read())  # Concatenate the content to the bank file
            bank_file.write(src_footer)

        # Files for which shifted versions were not made also don't have data
        file_names = get_data_file_names(output_dir, file_names)
        if len(file_names):
            bankpath = os.path.join(sprites_dir, "DAT"+bank) + ".asm"
            with open(bankpath, 'w') as bank_file:  # Open the bank file in append mode
                header = f"\nDAT{bank.ljust(17)}DATA  {bank}\n\n"
                bank_file.write(header)
                for file_name in file_names:
                    file_name = os.path.splitext(file_name)[0] + '-dat.txt'
                    filepath = os.path.join(output_dir, file_name)
                    with open(filepath, 'r') as data_file:
                        bank_file.write(data_file.read())  # Concatenate the content to the bank file
                bank_file.write(dat_footer)

#------------------------------------------------------------------------------
# MARK: convert_black_to_transparent
def convert_black_to_transparent(image):
    # Convert the image to RGBA mode (if not already)
    image = image.convert("RGBA")
    # Get pixel data
    pixels = image.getdata()
    # Create a new pixel list with transparency applied
    transparent_pixels = [(0, 0, 0, 0) if r == g == b == 0 else (r, g, b, pixel) for (r, g, b, pixel) in pixels]
    # Update the image with the new pixel data
    image.putdata(transparent_pixels)
    return image

#------------------------------------------------------------------------------
# MARK: fix_mrsprite_files
def fix_mrsprite_files(directory):
    print("Fixing Mr Sprite output for Orca/M")
    # regular expression pattern to match the filename format
    file_pattern = r'^([A-Za-z0-9_]+)-(\d{3})-([AaBb])\.txt$'

    for filename in os.listdir(directory):
        if filename.endswith(".txt"):
            match = re.match(file_pattern, filename)

            if match:
                filepath = os.path.join(directory, filename)
                alpha1, digits, alpha2 = match.groups()
                new_name = alpha1 + "_" + digits + alpha2
                name_entry = "; MARK: {}\n{:20}ENTRY\n                    ".format(new_name, new_name)

                # Read the content of the file
                with open(filepath, "r") as file:
                    content = file.read()

                patterns_replacements = {
                    r'Spr_000\s+(?=CLC)': name_entry,
                    r'\bLDAL\b': 'LDA',
                    r'\bSTAL\b': 'STA',
                    r'SEP\s+#\$20': 'SHORT M',
                    r'REP\s+#\$30': 'LONG M',
                    r' StackAddress': '>STACKADDRESS',
                    r'\n\*': '\n;'
                }

                # fix the contents of the file
                for pattern, replacement in patterns_replacements.items():
                    content = re.sub(pattern, replacement, content)                
                
                # Write the modified content back to the file
                with open(filepath, "w") as file:
                    file.write(content)

#------------------------------------------------------------------------------
# MARK: frame_width_extent
def frame_width_extent(image, frame_width, frame_height, offset_x, offset_y, pad_x, pad_y):
    width = image.width
    height = image.height
    for y in range(offset_y, height, frame_height + pad_y):
        for x in range(offset_x, width, frame_width + pad_x):
            if not all(p[:3] == (0, 0, 0) for p in (image.getpixel((x + frame_width - 1, y + frame_y)) for frame_y in range(frame_height))):
                return True
    return False

#------------------------------------------------------------------------------
# MARK: generate_text_image_data
def generate_text_image_data(output_file_path, image):
    # Get the pixel data
    pixels = list(image.getdata())
    output_file_path = os.path.splitext(output_file_path)[0] + '-dat.txt'
    file_pattern = r'.*[\\|/]([A-Za-z0-9_]+)-(\d{3})-([AaBb])-dat\.txt$'
    match = re.match(file_pattern, output_file_path)
    if match:
        alpha1, digits, alpha2 = match.groups()
        new_name = alpha1 + "_" + digits + alpha2
        new_data_name = "; MARK: {}\n{:20}ENTRY                    ".format(new_name + "_DATA", new_name + "_DATA")
        new_mask_name = "; MARK: {}\n{:20}ENTRY                    ".format(new_name + "_MASK", new_name + "_MASK")

    # Open the output file for writing
    with open(output_file_path, "w") as f:
        f.write(new_data_name)
        for i, pixel in enumerate(pixels):
            if i % image.width == 0:
                if i != 0:
                    f.write("'")
                f.write("\n                        dc    h'")
            # Write the palette index as a hex value
            f.write(f"{pixel:X}")

        f.write("'\n\n"+new_mask_name)
        for i, pixel in enumerate(pixels):
            if i % image.width == 0:
                if i != 0:
                    f.write("'")
                f.write("\n                        dc    h'")
            # Write the mask as a hex value
            f.write("F" if not pixel else "0")
        f.write("'\n\n")

#------------------------------------------------------------------------------
# MARK: get_data_file_names
def get_data_file_names(output_dir, file_names):
    files_to_process = []
    for file_name in file_names:
        new_file_name = os.path.splitext(file_name)[0]
        new_file_name = new_file_name + '-dat.txt'
        filepath = os.path.join(output_dir, new_file_name)
        if os.path.exists(filepath):
            files_to_process.append(file_name)
    return files_to_process

#------------------------------------------------------------------------------
# MARK: load_palette
def load_palette(palette_file):
    image_colors = {}
    with open(palette_file, 'r') as file:
        for line in file:
            line = line.strip()
            if line and not line.startswith('#'):
                key, value = line.split(maxsplit=1)
                value = value.split('#')[0].strip()  # Extract the value before any comments
                image_colors[key] = int(value)
    return image_colors

#------------------------------------------------------------------------------
# MARK: make_power_of_2
def make_power_of_2(image, x_axis, y_axis):
    if x_axis == y_axis == 0:
        return image

    width, height = image.size
    new_width = width
    new_height = height
    if x_axis:
        new_width = next_power_of_two(width)
    if y_axis:
        new_height = next_power_of_two(height)
    if new_width == width and new_height == height:
        return image
    new_image = Image.new("RGBA", (new_width, new_height), (0, 0, 0, 0))
    new_image.paste(image, (0, 0))
    return new_image

#------------------------------------------------------------------------------
# MARK: next_power_of_two
def next_power_of_two(n):
    # If n is already a power of 2, return n
    if n and not (n & (n - 1)):
        return n
    # Find the next power of 2
    return 2 ** math.ceil(math.log2(n))

#------------------------------------------------------------------------------
# MARK: pad_image
def pad_image(image, pad_value, flag):
    # Get the size of the original image
    width, height = image.size
    # Calculate the new width after padding
    new_width = width + abs(pad_value)
    # Create a new image with the updated width
    new_image = Image.new("RGBA", (new_width, height), (0, 0, 0, 0))
    # Determine the paste position based on the flag and pad value
    if pad_value < 0:  # Padding on the left
        paste_position = (-pad_value, 0)
    else:  # Padding on the right
        paste_position = (0, 0)
    # Paste the original image onto the new image
    new_image.paste(image, paste_position)
    if flag:
        if pad_value < 0:  # Padding on the left
            new_image = new_image.crop((0, 0, width, height))
        else:  # Padding on the right
            new_image = new_image.crop((pad_value, 0, width + pad_value, height))
    return new_image

#------------------------------------------------------------------------------
# MARK: parse_params
def parse_params(params):
    defaults = [None, "SPRITES", 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]  # Default parameter values
    parsed_params = params.split(':')
    parsed_params.extend([''] * (len(defaults) - len(parsed_params)))  # Extend parsed_params with empty strings
    parsed_params = [int(val) if val and i >= 2 else val if val else defaults[i] for i, val in enumerate(parsed_params)]
    return parsed_params

#------------------------------------------------------------------------------
# MARK: process_files
def process_files(input_file, output_dir):
    print("Generating frames")
    # Read input file
    with open(input_file, 'r') as f:
        lines = f.readlines()

    for line in lines:
        line = line.strip()
        if not line or line.startswith('#'):
            continue  # Skip blank lines and comments
        
        # Split file name and parameters
        parts = line.split()
        file_name = parts[0]
        params = parts[1] if len(parts) > 1 else ''  # Extract parameters if provided
        
        # Parse parameters
        output_file, output_bank_name, frame_width, frame_height, fixed_width, supress_odd_image, offset_x, offset_y, pad_x, pad_y, make_power_of_2_x, make_power_of_2_y = parse_params(params)
        
        # Open image
        image = Image.open(file_name)
        image = convert_black_to_transparent(image)
        width, height = image.size
        
        # Handle fixed width
        if fixed_width != '1':
            frame_width = width // frame_width
            frame_height = height // frame_height
        
        # Handle offsets
        offset_x = int(offset_x) if offset_x else 0
        offset_y = int(offset_y) if offset_y else 0
        
        # Handle padding
        pad_x = int(pad_x) if pad_x else 0
        pad_y = int(pad_y) if pad_y else 0

        if output_bank_name not in banks_of_sprites:
            banks_of_sprites[output_bank_name] = []

        if not frame_width % 2 and not supress_odd_image:
            force_wide = frame_width_extent(image, frame_width, frame_height, offset_x, offset_y, pad_x, pad_y)
        else:
            force_wide = False

        output_file_name = os.path.splitext(os.path.basename(file_name))[0].upper()
        if verbose:
            print("{:16} {:12} w:{:2} h:{:2}{:2}".format(
                output_file_name, output_bank_name, frame_width + 2 if force_wide else frame_width, frame_height,
                ''.join(" {}".format(var_name) for var_name, var_value in [
                    ('so', supress_odd_image), 
                    ('ox', offset_x), 
                    ('oy', offset_y), 
                    ('px', pad_x), 
                    ('py', pad_y),
                    ('^x', make_power_of_2_x),
                    ('^y', make_power_of_2_y)] if var_value != 0)))

        # Slice image and save frames
        name_counter = 0
        for y in range(offset_y, height, frame_height + pad_y):
            for x in range(offset_x, width, frame_width + pad_x):
                frame = image.crop((x, y, x + frame_width, y + frame_height))

                output_file_name = output_file or os.path.splitext(os.path.basename(file_name))[0]
                output_file_name = output_file_name.upper()
                frame_name = f"{output_file_name}-{name_counter:03d}-A.gif"
                banks_of_sprites[output_bank_name].append(frame_name)

                # Make the frame divisible by 2
                if frame.width % 2:
                    frame = pad_image(frame, 1, 0)

                if not supress_odd_image:
                    # Frame needs a blank col at right for the odd image to shift into, so if there's not 
                    # a blank col, have to add 2 col's to keep divisible by 2, as it is already div 2
                    if force_wide: # or not all(p[:3] == (0, 0, 0) for p in (frame.getpixel((frame.width - 1, y)) for y in range(frame.height))):
                        frame = pad_image(frame, 2, 0)
                    # Make the odd_image
                    odd_image = frame.copy()
                    # Shift it right by 1 and clip to same size
                    odd_image = pad_image(odd_image, -1, 1)
                    # Make odd_image a power of 2 if necessary
                    odd_image = make_power_of_2(odd_image, make_power_of_2_x, make_power_of_2_y)
                    # Convert odd_image to paletted mode
                    odd_image = odd_image.convert("P", palette=Image.ADAPTIVE, colors=16)
                    odd_image = remap_image_colors(odd_image, palette, palette_rgb)

                    # Save odd_image as a paletted GIF file
                    odd_frame_name = f"{output_file_name}-{name_counter:03d}-B.gif"
                    banks_of_sprites[output_bank_name].append(odd_frame_name)
                    output_file_path = os.path.join(output_dir, odd_frame_name)
                    odd_image.save(output_file_path, format="GIF", overwrite=True)
                    generate_text_image_data(output_file_path, odd_image)

                # Make frame a power of 2 if necessary
                frame = make_power_of_2(frame, make_power_of_2_x, make_power_of_2_y)

                # Convert frame to paletted mode
                frame = frame.convert("P", palette=Image.ADAPTIVE, colors=16)
                frame = remap_image_colors(frame, palette, palette_rgb)
                # Save frame as a paletted GIF
                output_file_path = os.path.join(output_dir, frame_name)
                frame.save(output_file_path, format="GIF", overwrite=True)
                if not supress_odd_image:
                    generate_text_image_data(output_file_path, frame)
                # Next frame has next number
                name_counter += 1

#------------------------------------------------------------------------------
# MARK: remap_image_colors
def remap_image_colors(image, palette, palette_rgb):
    image_palette = image.getpalette()
    image_palette_hex = [f"{image_palette[i]:02X}{image_palette[i+1]:02X}{image_palette[i+2]:02X}" for i in range(0, len(image_palette), 3)]
    pixels = image.load()
    # Remap the colors in the image
    for y in range(image.size[1]):
        for x in range(image.size[0]):
            pixel = pixels[x, y]
            pixels[x, y] = palette[image_palette_hex[pixel]]

    image.putpalette(palette_rgb)
    return image
  
#------------------------------------------------------------------------------
if __name__ == "__main__":
    if len(sys.argv) < 5:
        print("\nUsage: python mkspr.py input_file palette_file output_directory sprite_directory [verbose level]")
        print("\nInput file contains the names of image files to be converted, optionally followed by parameters.")
        print("Optional parameters after file name in input file: (Default in brackets)")
        print(" 0 - (input file name) output file/sprite frame base name")
        print(" 1 - (SPRITES) sprite bank (class) name")
        print(" 2 - (1) Input frame size or count in width (look at parameter 4)")
        print(" 3 - (1) Input frame size or count in height (look at parameter 4)")
        print(" 4 - (0) 1 means frame_count is a fixed size, not size / parameter 1 or 2")
        print(" 5 - (0) Supress making a shifted right by 1 column version of each frame")
        print(" 6 - (0) offset in X - Only start processing the image at this pixel column in the width")
        print(" 7 - (0) offset in Y - Only start processing the image at this pixel row in the height")
        print(" 8 - (0) pad X - skip X pixels between frames in the input image width")
        print(" 9 - (0) pad Y - skip Y pixels between frames in the input image height")
        print("10 - (0) 1 means make a power of 2 in X (otherwise just divisible by 2)")
        print("11 - (0) 1 means make power of 2 in Y (otherwise just divisible by 2)")
        print("Palette file has hex color indicies for the game palette (in the form FFGGBB)")
        print("Output directory is a temporary work area")
        print("Sprite directory is where the final sprite code and data is written (to be compiled into game)")
        print("Verbosity level is blank for off, 1 or 2 for more printing)")
        print("ALL OUTPUT FILES WILL OVERWRITE EXISTING FILES")

        sys.exit(1)

    input_file = sys.argv[1]
    palette = load_palette(sys.argv[2])
    palette_rgb = [int(color[i:i+2], 16) for color in palette for i in (0, 2, 4)]

    output_dir = sys.argv[3]
    sprites_dir = sys.argv[4]
    verbose = int(sys.argv[5]) if len(sys.argv) > 5 else None

    # Create output directory if it doesn't exist
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Create output directory if it doesn't exist
    if not os.path.exists(sprites_dir):
        os.makedirs(sprites_dir)

    process_files(input_file, output_dir)
    devnull = open(os.devnull, 'w') if not verbose or verbose < 2 else None
    # [*palette] turns keys in dictionary into an array
    subprocess.run(["mrsprite.exe", "CODE"] + [output_dir + "\*.gif"] + ["000000"] + [*palette], stdout=devnull)
    fix_mrsprite_files(output_dir)
    consolidate_sprite_banks(output_dir, sprites_dir)
