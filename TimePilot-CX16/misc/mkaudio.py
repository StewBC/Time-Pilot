# mkaudio.py by Stefan Wessels, Feb 2024.
# use python.exe .\mkaudio.py --help to see detailed help

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

    parser = argparse.ArgumentParser(description='process PCM audio data into a Commander X16 ram bank chunks.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=textwrap.dedent('''\
            example usage:
             -i ../misc/audio.txt -o ../assets/bank
            this will process the files listed in audio.txt and concatenate them into files 
            in assets with the file names having the format bankXXX.au, where XXX is a number
            starting from the bank specified with -a (default 1).
            audio.txt contains something like:
            # file name         loops?
            game_start.pcm
            highscore.pcm         1
            the output will show a table like below:
            {0x01,0x153F,0x0C,0x0926,0},
            {0x0C,0x0927,0x17,0x0577,1},
            the 1st column is the starting bank, start address in bank, end bank,
            end address in end bank and lastly whether the sample should loop.
            the order of the table is the order of the files in audio.txt.
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
                        help="do not write a CBM address preamble to the output AU files.")
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
