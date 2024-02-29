# mkvram.py by Stefan Wessels, Feb 2024.
# use python.exe .\mkvram.py --help to see detailed help

import argparse, sys, textwrap

class Information:
    def __init__(self, file_name="", start_bank = 0, start_address= 0, end_bank = 0, end_address = 0, loops=0):
        self.file_name    = file_name
        self.start_bank   = start_bank
        self.start_address = start_address
        self.end_bank     = end_bank
        self.end_address  = end_address
        self.loops        = loops

#-----------------------------------------------------------------------------
def read_files_into_bytearray(file_names, start_bank):
    information = []
    combined_bytearray = bytearray()
    for file_name, loops in file_names.items():
        current_length = len(combined_bytearray)
        with open(file_name, 'rb') as file:
            file_contents = file.read()
            combined_bytearray.extend(file_contents)
        new_length = len(combined_bytearray) -1
        information.append(
            Information(file_name, 
                        start_bank + int(current_length / 8192),
                        current_length % 8192,
                        start_bank + int(new_length / 8192),
                        new_length % 8192,
                        loops))

    return combined_bytearray, information

#-----------------------------------------------------------------------------
def parseLines(lines):
    dictionary = dict()
    for line in (lines):
        line = line.strip()
        if len(line) == 0 or line[0] == '#':
            continue
        if '#' in line:
            content, comment = line.split('#')
            line = content.strip()
        if ' ' in line:
            key, value = line.split()
        else:
            key = line
            value = '0'
        dictionary[key.strip()] = value.strip()
    lines.clear()
    return dictionary

#-----------------------------------------------------------------------------
def file2dict(fileName):
    fin = open(fileName, 'r')
    inputLines = fin.readlines()
    fin.close()
    return parseLines(inputLines)

#-----------------------------------------------------------------------------
def main():
    inputDict = dict()

    parser = argparse.ArgumentParser(description='process PCM aufio data into a Commander X16 ram bank chunks.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=textwrap.dedent('''\
            additional information:
              conversion properties means the following information as a string, seperated by colon's,
              with their default values shown in brackets:
                frames in width                 (1) - how many cells are there in the input, in the width
                frames in height                (1) - how many cells are there in the input, in the height
                bit depth of output             (4) - 1, 4 or 8 bits per pixel in the output
                frame is a cell                 (0) - when not zero, frames specify the input cell sizes
                width offset - X                (0) - start at X in image
                height offset - Y               (0) - start ay Y in image
                input cell width padding        (0) - width of any frame between cells
                input cell height padding       (0) - height of frame between cells
                skip outputting duplicate cells (0) - omit outputting duplicate cells
                output cells are a power of two (1) - output cells are padded at right, bottom to 8, 16, 32 or 64

            examples:
            1) -g "font.png 8:8:1:1:1:1:1:1"
              a font file containing 128 characters in an 16x8 grid, each seperated by a single line frame -
              from left to right: each character is 8x8, bit depth of output is 1 bpp, the sizes (8x8) are for
              each sub cell (or character), start at (1,1) in the image to skip the frame, and each cell has
              an extra 1 in width and height to account for the frame.  skip duplicates and power of two are
              not specified and assume their default values of 0 and 1.
            2) -g "logo.png 2:::::::::0"
              The width of logo contains two cells horizontally (we don't specify the width).  All other values
              use defaults, except power of two is off, so the width and height output are left as-is.
            '''))
    inputGroup = parser.add_argument_group('input arguments are one or both of:')
    inputGroup.add_argument('-i', '--input', metavar='input_file',
                        help='the name of the file containing a list of PCM files to pack.')
    inputGroup.add_argument('-p', '--pcm', nargs='*', metavar='pcm_file',
                        help='file names of pcm files to pack - appended to the list with -i if -i was used.')
    parser.add_argument('-o', '--output', metavar='output_file', required=True,
                        help='output audio file base name.')
    parser.add_argument('-a', '--address',
                        help='the address to start the pack at - Default is 1A000.')
    parser.set_defaults(address='1A000')
    parser.add_argument('-n', '--no-address', action='store_true',
                        help="do not write a CBM address preamble to the output VRAM data blob.")
    args = parser.parse_args()

    try:
        if not (args.input or args.pcm):
            raise NameError("ERROR: One of -i (input) or -p (pcm), or both, must be specified.\n")
        
        if args.input:
            inputDict = file2dict(args.input)

        if args.pcm:
            inputDict.update(parseLines(args.pcm))

        if args.address:
            if(len(args.address) != 5):
                raise NameError("ERROR: -a (address) must be a 5 digit hexadecimal number.\n")
            bank = int(args.address[0])
            addr = int(args.address[1:5], 16).to_bytes(2, 'little')

        binarydata = bytearray()
        binarydata, information = read_files_into_bytearray(inputDict, bank)
        length = len(binarydata)
        offset = 0
        current_bank = bank
        while(length):
            fileName = (("%s%03d.au" % (args.output, current_bank)))
            fout = open(fileName, 'wb')
            current_bank += 1
            if(not args.no_address):
                fout.write(addr)
            block_size = length if length < 8192 else 8192
            fout.write(binarydata[offset:offset+block_size])
            fout.close()
            offset += block_size
            length -= block_size
        for info in information:
            print("Name: {} Bank: {} Start: {} End bank {} End {}".format(info.file_name, info.start_bank, info.start_address, info.end_bank, info.end_address))
        print("Total size: {} - verify {}\n".format(len(binarydata), (info.end_bank - bank)* 8192 + 1 + info.end_address))
        for info in information:
            print("{{0x{:02X},0x{:04X},0x{:02X},0x{:04X},{}}},".format(info.start_bank, info.start_address, info.end_bank, info.end_address, info.loops))


    except (OSError, IOError, NameError) as e:
        sys.stderr.write(str(e))

if __name__ == "__main__":
    main()
