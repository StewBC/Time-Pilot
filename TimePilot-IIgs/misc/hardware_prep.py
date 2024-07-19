import os
import shutil

# Define paths for external tools, edit these to suit your system
CP2_EXECUTABLE = "C:/Users/swessels/Apps/CiderPress-II/cp2.exe"
ORCA_INCLUDE_PATH = "/gs.dev/orca/libraries/orcainclude/m16="

# Project specific names
SHK_ARCHIVE_NAME = "tp.source.shk"
IIGS_EXECUTABLE_NAME = "TIME.PILOT"
IIGS_GAME_NAME = "GAME"
MAIN_FILE = "obj:main" # entry point

# Constants for directory and file manipulation
SOURCES = ["src", "snd", "Icons", "history"]
TARGET_DIR = "IIgs"
CR_LINE_ENDING = "\r"
ALLOWED_EXTENSIONS = [".icon", ".asm", ".snd", ".s"]
INCLUDE_FILES = ["snd/soundbank", "history/ReadMeFirst"]
MAKE_FILES = ["make", "make.clean", "make.macros"]

# Function to copy directories
def copy_tree(sources, target_dir):
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)
    os.makedirs(target_dir)

    new_dirs = []
    for source in sources:
        new_dir = os.path.join(target_dir, source)
        shutil.copytree(source, new_dir)
        new_dirs.append(new_dir)

    return new_dirs

# Function to create defines dynamically
def make_defines(sources, target_dir):
    defines = {}
    for source in sources:
        define_name = f"NEW_{source.upper()}_DIR"
        define_path = os.path.join(target_dir, source)
        defines[define_name] = define_path
    return defines

def delete_unwanted_files(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir):

        for filename in filenames:
            # Construct the full file path
            file_path = os.path.join(dirpath, filename)

            # Normalize file path and compare with INCLUDE_FILES list
            relative_file_path = os.path.relpath(file_path, root_dir)
            if any(os.path.normpath(relative_file_path) == os.path.normpath(include_file) for include_file in INCLUDE_FILES):
                continue

            if not any(filename.endswith(ext) for ext in ALLOWED_EXTENSIONS):
                file_path = os.path.join(dirpath, filename)
                print(f"Deleting {file_path}")
                os.remove(file_path)

def write_with_cr(file_path, lines):
    """Write lines to a file, using CR as line ending."""
    with open(file_path, 'w', newline=CR_LINE_ENDING) as file:
        for line in lines:
            modified_line = line.replace('/', ':').replace('\\', ':')
            file.write(modified_line)

def process_files():
    # Copy the directories
    new_dirs = copy_tree(SOURCES, TARGET_DIR)

    # Create the defines
    defines = make_defines(SOURCES, TARGET_DIR)

    # Get the define to use
    NEW_SOURCE_DIR = defines["NEW_SRC_DIR"]

    delete_unwanted_files(TARGET_DIR)

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
            else:
                # Normalize line endings to CR for all other files
                with open(full_path, 'r', newline=None) as file:
                    content = file.read().replace('\n', CR_LINE_ENDING)
                with open(full_path, 'w', newline=None) as file:
                    file.write(content)


    # Create and fill the 'make' file
    make_path = os.path.join(TARGET_DIR, "make")
    write_with_cr(make_path, ["make.clean\n"] + [f"assemble src/{path[:-4]} keep=obj/{path[:-4]}\n" for path in asm_files] +
                [f"assemble link.script keep={IIGS_GAME_NAME}\n", f"link +S obj:loader keep={IIGS_EXECUTABLE_NAME}\n",
                f"filetype {IIGS_GAME_NAME} S16\n", f"filetype {IIGS_EXECUTABLE_NAME} S16\n"])

    # Create and fill the 'make.macros' file
    make_macros_path = os.path.join(TARGET_DIR, "make.macros")
    write_with_cr(make_macros_path, [f"macgen src/{path[:-4]} src/{path[:-4]}.mac src/macros/macros.s {ORCA_INCLUDE_PATH}\n" for path in asm_files])

    # Create and fill the 'link.script' file
    link_script_path = os.path.join(TARGET_DIR, "link.script")
    asm_files.remove("main.asm")    # Move main to the top
    asm_files.insert(0,"main.asm")
    asm_files.remove("loader.asm")  # Loader not linked to the GAME
    write_with_cr(link_script_path, [f"obj/{path[:-4]}\n" for path in asm_files])

    # Create and fill the 'make.clean' file
    make_clean_path = os.path.join(TARGET_DIR, "make.clean")
    write_with_cr(make_clean_path, ["delete obj\n", f"delete {IIGS_GAME_NAME}\n", f"delete {IIGS_EXECUTABLE_NAME}\n"] +
                [f"create obj/{folder}\n" for folder in sub_folders])

    # Use CP2 to make an SHK archibe with all file attributes correct for using on hardware
    os.chdir(TARGET_DIR)
    if os.path.exists("{SHK_ARCHIVE_NAME}"):
        os.remove("{SHK_ARCHIVE_NAME}")
    # Make the folders
    for source_folder in SOURCES:
        os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} {source_folder}")
    # Add the scripts
    for make_file in MAKE_FILES:
        os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} {make_file}")
    os.system(f"{CP2_EXECUTABLE} add {SHK_ARCHIVE_NAME} link.script")

    # Set attributes for all files under src
    for root, dirs, files in os.walk("src"):  # Navigate subfolder structure
        for file in files:
            # Construct file path in the format expected by cp2.exe
            folder_path = os.path.join(root, file).replace('\\', ':').replace('/', ':')
            os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"{folder_path}\" type=SRC aux=0x0003")

    # Set attributes for all files under snd
    for root, dirs, files in os.walk("snd"):  # Navigate subfolder structure
        for file in files:
            # Construct file path in the format expected by cp2.exe
            folder_path = os.path.join(root, file).replace('\\', ':').replace('/', ':')
            os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"{folder_path}\" type=BIN aux=0x00D6")

    # Set attributes for make files
    for make_file in MAKE_FILES:
        os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"{make_file}\" type=SRC aux=0x0006")

    # Set attributes for link.script
    os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"link.script\" type=SRC aux=0x0109")

    # Set attributes for the icons
    os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"Icons\" type=ICN aux=0x0000")

    # Set attributes for the ReadMeFirst
    os.system(f"{CP2_EXECUTABLE} sa {SHK_ARCHIVE_NAME} \"history:ReadMeFirst\" type=GWP aux=0x5445")

# Run the file processing
process_files()

# Assumptions about the environment
print("\n\n==========================================================================\n"
      "This assumed that on the Apple IIgs, Orca's macro files are installed as:\n"
      f"{ORCA_INCLUDE_PATH}\n"
      "Edit the python code if this is not the case, or if cp2 was not found.\n"
      "cp2 is the command-line version of CiderPress II\n"
      "==========================================================================\n")

