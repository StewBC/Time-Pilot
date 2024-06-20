import os
import shutil

# Define paths for external tools, edit these to suit your system
CP2_EXECUTABLE = "C:/Users/swessels/Apps/CiderPress-II/cp2.exe"
ORCA_INCLUDE_PATH = "/gs.dev/orca/libraries/orcainclude/m16="

# Project specific names
SHK_ARCHIVE_NAME = "tp.source.shk"
IIGS_EXECUTABLE_NAME = "TIME.PILOT"
MAIN_FILE = "obj:main" # entry point

# Constants for directory and file manipulation
SOURCE_DIR = "src"
TARGET_DIR = "IIgs"
NEW_SOURCE_DIR = os.path.join(TARGET_DIR, SOURCE_DIR)
CR_LINE_ENDING = "\r"

def write_with_cr(file_path, lines):
    """Write lines to a file, using CR as line ending."""
    with open(file_path, 'w', newline=CR_LINE_ENDING) as file:
        for line in lines:
            modified_line = line.replace('/', ':').replace('\\', ':')
            file.write(modified_line)

def move_line_to_top(filename, target_line):
    """Move the target_line to the top of the file in filename"""
    with open(filename, 'r') as file:
        lines = file.readlines()

    # Strip newline characters for accurate comparison and manipulation
    lines = [line.strip() for line in lines]

    if target_line in lines:
        # Remove the target line and reinsert it at the top
        lines.remove(target_line)
        lines.insert(0, target_line)
        
        lines_with_newlines = [line + '\n' for line in lines]
        # Write the modified list back to the file
        write_with_cr(filename, lines_with_newlines)
    else:
        print(f"Error: '{target_line}' not found in the file.")

def process_files():
    # Ensure the target directory structure exists
    if os.path.exists(TARGET_DIR):
        shutil.rmtree(TARGET_DIR)
    if not os.path.exists(TARGET_DIR):
        os.makedirs(TARGET_DIR)
    if os.path.exists(NEW_SOURCE_DIR):
        shutil.rmtree(NEW_SOURCE_DIR)
    shutil.copytree(SOURCE_DIR, NEW_SOURCE_DIR)

    # Lists to store different file types and paths
    asm_files = []
    sub_folders = set()

    # Walk through the source directory and process files
    for root, dirs, files in os.walk(NEW_SOURCE_DIR):
        for name in files:
            full_path = os.path.join(root, name)
            relative_path = os.path.relpath(full_path, NEW_SOURCE_DIR)
            sub_folders.update([os.path.dirname(relative_path)])

            if name.endswith(".asm"):
                asm_files.append(relative_path)
                # Remove .asm extension
                new_path = full_path[:-4]
                os.rename(full_path, new_path)
                # Replace content with CR line endings
                with open(new_path, 'r', newline=None) as file:
                    content = file.read().replace('\n', CR_LINE_ENDING)
                with open(new_path, 'w', newline=None) as file:
                    file.write(content)
            elif name.endswith(".mac"):
                os.remove(full_path)  # Ignore .mac files
            else:
                # Normalize line endings to CR for all other files
                with open(full_path, 'r', newline=None) as file:
                    content = file.read().replace('\n', CR_LINE_ENDING)
                with open(full_path, 'w', newline=None) as file:
                    file.write(content)

    # Create and fill the 'make' file
    make_path = os.path.join(TARGET_DIR, "make")
    write_with_cr(make_path, ["make.clean\n"] + [f"assemble src/{path[:-4]} keep=obj/{path[:-4]}\n" for path in asm_files] + 
                [f"assemble link.script keep={IIGS_EXECUTABLE_NAME}\n", f"filetype {IIGS_EXECUTABLE_NAME} S16\n"])

    # Create and fill the 'link.script' file
    link_script_path = os.path.join(TARGET_DIR, "link.script")
    write_with_cr(link_script_path, [f"obj/{path[:-4]}\n" for path in asm_files])
    move_line_to_top(link_script_path, f'{MAIN_FILE}')

    # Create and fill the 'make.clean' file
    make_clean_path = os.path.join(TARGET_DIR, "make.clean")
    write_with_cr(make_clean_path, ["delete obj\n", f"delete {IIGS_EXECUTABLE_NAME}\n"] + 
                [f"create obj/{folder}\n" for folder in sub_folders])

    # Create and fill the 'make.macros' file
    make_macros_path = os.path.join(TARGET_DIR, "make.macros")
    write_with_cr(make_macros_path, [f"macgen src/{path[:-4]} src/{path[:-4]}.mac src/macros/macros.s {ORCA_INCLUDE_PATH}\n" for path in asm_files])

    # Use CP2 to make an SHK archibe with all file attributes correct for using on hardware
    os.chdir(TARGET_DIR)
    if os.path.exists("{SHK_ARCHIVE_NAME}"):
        os.remove("{SHK_ARCHIVE_NAME}")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} src")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} make")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} make.clean")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} make.macros")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} link.script")

    # Set attributes for all files under src
    for root, dirs, files in os.walk("src"):  # Navigate subfolder structure
        for file in files:
            # Construct file path in the format expected by cp2.exe
            folder_path = os.path.join(root, file).replace('\\', ':').replace('/', ':')
            os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"{folder_path}\" type=SRC aux=0x0003")

    # Set attributes for make files
    make_files = ["make", "make.clean", "make.macros"]
    for make_file in make_files:
        os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"{make_file}\" type=SRC aux=0x0006")

    # Set attributes for link.script
    os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"link.script\" type=SRC aux=0x0109")

# Run the file processing
process_files()

# Assumptions about the environment
print("\n\n==========================================================================\n"
      "This assumed that on the Apple IIgs, Orca's macro files are installed as:\n"
      f"{ORCA_INCLUDE_PATH}\n"
      "Edit the python code if this is not the case, or if cp2 was not found.\n"
      "cp2 is the command-line version of CiderPress II\n"
      "==========================================================================\n")

