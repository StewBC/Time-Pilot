# mkvram.py by Stefan Wessels, Feb 2024.
# use python.exe .\mkvram.py --help to see detailed help

import argparse, sys, hashlib, math, textwrap
from PIL import Image

palDict = dict()

class Parameters:
    def __init__(self):
        self.framesX     = 1
        self.framesY     = 1
        self.bitDepth    = 4
        self.frameIsCell = 0
        self.offsetX     = 0
        self.offsetY     = 0
        self.cellPadX    = 0
        self.cellPadY    = 0
        self.skipdupes   = 0
        self.pow2        = 1

#-----------------------------------------------------------------------------
def convert(fileName, p):
    # load the image
    sheet = Image.open(fileName)

    # translate the bit depth (1, 4, 8) into number of shifts (+1) needed to output a byte (8, 2, 1)
    numShifts = 1 << (3 - (p.bitDepth.bit_length() - 1))

    if p.frameIsCell:
        # if the specified paramete is the w/h of each sub-image, calculate 
        # what the frame looks like
        inX = p.framesX
        inY = p.framesY
        p.framesX = math.ceil((sheet.width  - p.offsetX) / (inY + p.cellPadX))
        p.framesY = math.ceil((sheet.height - p.offsetY) / (inX + p.cellPadY))
    else:
        # but if the specified dimention is how many frames there are, calculate
        # how wide/hight each sub-image has to be
        inX = int((sheet.width  - p.offsetX - p.framesX * p.cellPadX) / p.framesX)
        inY = int((sheet.height - p.offsetY - p.framesY * p.cellPadY) / p.framesY)
    # assume output sub-image is same as input sub-image
    outX = inX
    outY = inY
    if p.pow2:
        # but if it is not, calculate what the next power of 2 size is
        outX = 8 if inX < 4 else 2**(math.ceil(math.log(inX)/math.log(2)))
        outY = 8 if inY < 4 else 2**(math.ceil(math.log(inY)/math.log(2)))

    # array for output pixel values
    image_array = bytearray()
    # array for hashes to detect duplicates if detection is needed
    hash_array = []

    # debug - show the parameters
    # print([getattr(p, attr) for attr in vars(p) if not attr.startswith('__')])

    try:
        pal0 = palDict["000000"]
        y1 = p.offsetY
        for y in range(p.framesY):
            x1 = p.offsetX
            for x in range(p.framesX):
                sha256 = hashlib.sha256()
                # Extract the sub-image
                icon = sheet.crop((x1, y1, x1 + inX, y1 + inY))
                palettePixelValues = []
                widthOut = 0
                heightOut = 0
                ap = 0
                pixel = 0
                # get the pixel values
                for rgb in list(icon.getdata()):
                    output = '%02X%02X%02X' % (rgb[0], rgb[1], rgb[2])
                    palIdx = palDict[output]
                    pixel <<= p.bitDepth
                    if numShifts == 8:
                        if palIdx != pal0:
                            pixel |= 1
                    else:
                        pixel |= palIdx
                    ap += 1
                    if ap == numShifts:
                        palettePixelValues.append(pixel)
                        pixel = 0
                        ap = 0
                    widthOut += 1
                    if widthOut == inX:
                        # pad this line out to the desired width
                        while widthOut < outX:
                            pixel <<= 4
                            pixel |= pal0
                            ap += 1
                            if ap == 2:
                                palettePixelValues.append(pixel)
                                pixel = 0
                                ap = 0
                            widthOut += 1
                        # done a line
                        widthOut = 0
                        heightOut += 1
                # done the sub-image.  Make an empty pixel byte
                pal0 |= (pal0 << 4)
                # pad out the rest of the rows for the desired out size if needed
                while heightOut < outY:
                    while widthOut < outX:
                        palettePixelValues.append(pal0)
                        widthOut += 2
                    widthOut = 0
                    heightOut += 1
                # make the array of of output for this sub-image
                icon_byte_array = bytearray(palettePixelValues)
                # this doesn't currently make a lot of sense since there's
                # no output to say a duplicate was skipped, and which "tile"
                # is the same one - future enhancement should I need it
                if p.skipdupes:
                    # see if this sub-image was already emitted
                    sha256.update(icon_byte_array)
                    hashV = sha256.hexdigest()
                    if hashV not in hash_array:
                        # and if not, emit it
                        hash_array.append(hashV)
                        image_array.extend(icon_byte_array)
                else:
                    # emit without checking if it might be a duplicate sub-image
                    image_array.extend(icon_byte_array)
                # next sub-image in row
                x1 += inX + p.cellPadX
            # next column of sub-images in a row
            y1 += inY + p.cellPadY
        
    except (KeyError) as e:
        print(("ERR : %s, Unknown key %s" % (fileName, e)))
    
    return image_array


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
            key, value = line.split(' ')
        else:
            key = line
            value = '1'
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
    # remapDict = dict()
    binarydata = bytearray()
    filedata = bytearray()

    parser = argparse.ArgumentParser(description='process image data into a Commander X16 VRAM chunk.',
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
    inputGroup.add_argument('-i', '--input', metavar='sprite_list_file',
                        help='the name of the file containing a list of images and conversion properties, to process.')
    inputGroup.add_argument('-g', '--graphic', nargs='*', metavar='image_file',
                        help='file names and conversion properties of an image to convert - appended to the list with -i if -i was used.')
    parser.add_argument('-o', '--output', metavar='VRAM_file', required=True,
                        help='output VRAM file name.')
    parser.add_argument('-p', '--palette', metavar='palette_file', required=True,
                        help='the name of a file containing key value pairs that map palette colours (HEX RGB) to palette indicies, for example 808080 8.')
    parser.add_argument('-a', '--address',
                        help='the address to start the VRAM data blob at Format is bYYYY where b is the bank <0|1> and YYYY is the address in HEX. default is 13000.')
    parser.set_defaults(address='13000')
    parser.add_argument('-n', '--no-address', action='store_true',
                        help="do not write a CBM address preamble to the output VRAM data blob.")
    args = parser.parse_args()

    try:
        if not (args.input or args.graphic):
            raise NameError("ERROR: One of -i (input) or -g (graphic), or both, must be specified.\n")
        
        fout = open(args.output, 'wb')

        if args.input:
            inputDict = file2dict(args.input)

        if args.graphic:
            inputDict.update(parseLines(args.graphic))

        if args.palette:
            palDict.update(file2dict(args.palette))
            for key, value in palDict.items():
                palDict[key] = int(value)

        if args.address:
            if(len(args.address) != 5):
                raise NameError("ERROR: -a (address) must be a 5 digit hexadecimal number.\n")
            bank = args.address[0]
            addr = int(args.address[1:5], 16).to_bytes(2, 'little')

        if(not args.no_address):
            fout.write(addr)

        offset = 0
        length = 0
        p = Parameters()
        # process all the input files
        for file, params in inputDict.items():
                                                        # populate array from struct
            a = [getattr(p, attr) for attr in vars(p) if not attr.startswith('__')]
            suppliedParams = [None] * len(a)            # get an array of user supplied parameters
            suppliedParams = params.split(':')
                                                        # Check user supplied parameters
            for i in range(min(len(suppliedParams), len(a))):
                if suppliedParams[i]:                   # Check if the parameter is not empty
                    a[i] = int(suppliedParams[i])       # replace defaults
            for i, attr in enumerate(vars(p)):          # stuff back into struct from array
                if not attr.startswith('__'):
                    setattr(p, attr, a[i])
            binarydata = convert(file, p)
            length = len(binarydata)
            hh = (int(args.address,16)+offset) >> 13
            hl = ((int(args.address,16)+offset) >> 5) & 255
            print(("File: %s start = %d size = %d %s %s" % (file, offset, length, hex(hh), hex(hl))))
            offset += length
            fout.write(binarydata)

        fout.close()
        print(('\nFile: %s size = %d\n' % (args.output, offset)))

    except (OSError, IOError, NameError) as e:
        sys.stderr.write(str(e))

if __name__ == "__main__":
    main()
