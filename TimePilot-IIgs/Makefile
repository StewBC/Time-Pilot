# GSOS related makefile.
# This will make src/*.asm to obj/*.root (.s code is added as a dependency as is .mac)
# To generate macros for all the src/*.asm files, use make macros

# Settings
PROGRAM := TIME.PILOT
TARGETOBJDIR := obj
LINKER_SCRIPT := link.scp
LINKER_OPTIONS := +L # +L to see the segment sizes
SRCDIR := src
LISTINGDIR := lst
GIFDIR := gif
HARDWAREDIR := IIgs
TEMPLATE_DISK := appleIIgs/gsos-template.2mg
TEMPLATE_FLOPPY := appleIIgs/800K-template.po
DISK := timepilot.2mg
FLOPPY := timepilot.po
VOLUME := TIMEPILOT
CADIUS := cadius.exe
MAME_ADDRESS := 0x91716 # For MAME debugging - address where code is loaded - need to run and then calculate
SED := "C:/Program Files/Git/usr/bin/sed.exe"
AWK := "C:/Program Files/Git/usr/bin/gawk.exe"
MYFIND := "C:/Program Files/Git/usr/bin/find.exe" # Because make uses sh from my path but I am on Windows and I need UNIX find


ifeq ($(shell echo),)
  PWD = pwd
  MKDIR = mkdir -p $1
  RMDIR = rm -rf $1
  RMFILES = $(RM) $1
  RMFILESR = $(MYFIND) $1 -type f -delete
  CP = cp $1

else
  PWD = cd
  MKDIR = mkdir $(subst /,\,$1)
  RMDIR = rmdir /S /Q $(subst /,\,$1)
  RMFILES = $(if $1,del /f /q $(subst /,\,$1))
  RMFILESR = for /R $(subst /,\,$1) %%f in (*) do del /F /Q "%%f"
  CP = copy $(subst /,\,$1)
endif

define NEWLINE


endef

SOURCES := $(wildcard $(SRCDIR)/*.asm)
SOURCES += $(wildcard $(SRCDIR)/sprites/*.asm)
SOURCES := $(filter-out $(SRCDIR)/main.asm,$(SOURCES))
SOURCES := $(SRCDIR)/main.asm $(SOURCES)
OBJECTS += $(subst .asm,.ROOT,$(subst $(SRCDIR),$(TARGETOBJDIR),$(SOURCES))) 
LINK_OBJS := $(subst .ROOT,,$(OBJECTS))
define LINK_OBJS_NAMES
	$(LINK_OBJS)
endef
export LINK_OBJS_NAMES

# TODO Pick an Emulator / Debugger
# Crossrunner highly suggested as it has full source debug
EMULATOR := CROSSRUNNER			# MAME, GSPORT, GSPLUS, KEGS & defaults to CROSSRUNNER
EMUCMP = $(strip $(EMULATOR))
ifeq ($(EMUCMP),MAME)
	mkfile_path := $(shell $(PWD))
	EMUDIR := C:/Users/swessels/games/mame0247b
	EMU := mame.exe apple2gs -gameio joy -nothrottle -debug -debugscript $(mkfile_path)/mame.dbg -sl7 cffa2 -hard1 $(mkfile_path)/$(DISK) 
	ifeq ($(shell echo),)
		EMU := ./$(EMU)
	endif
else ifeq ($(EMUCMP),GSPORT)
	EMUDIR := C:/Users/swessels/Games/gsport_0.31
	EMU := GSport.exe
else ifeq ($(EMUCMP),GSPLUS)
	EMUDIR := C:/Users/swessels/Apps/gsplus-win-sdl
	EMU := gsplus.exe
else ifeq ($(EMUCMP),KEGS)
	EMUDIR := C:/Users/swessels/Apps/gsplus-win-sdl
	EMU := kegswin.exe
else
	EMUDIR := C:/Program Files/Crossrunner
	EMU := Crossrunner.exe $(PROGRAM) -CompatibilityLayer -Speed=Fast -Map debug.map -source $(subst src,$(LISTINGDIR),$(SOURCES))
endif

vpath %.asm $(SRCDIR)

.PHONY: all art hardware test macros indent clean zap

# all does not build dsk and test (nor macros or indent). Manual make macros is required for a normal make to work.
all:	$(PROGRAM)

$(TARGETOBJDIR) $(LISTINGDIR):
	$(call MKDIR,$@)
	$(call MKDIR,$@/sprites)

$(TARGETOBJDIR)/%.ROOT: %.asm $(wildcard $(SRCDIR)/*.s) $(wildcard $(SRCDIR)/*.mac) | $(TARGETOBJDIR) $(LISTINGDIR)
ifeq ($(EMUCMP),CROSSRUNNER)
	iix assemble +L +S $< keep=$(subst /,:,$(basename $@)) > $(LISTINGDIR)$(subst src,,$<)
else
	iix assemble $< keep=$(subst /,:,$(basename $@))
endif

$(PROGRAM): $(OBJECTS) Makefile
	-$(call RMFILES,$(PROGRAM))
	@echo $(LINKER_OPTIONS) > $(LINKER_SCRIPT)
ifeq ($(shell echo),)
	@echo "$$LINK_OBJS_NAMES" >> $(LINKER_SCRIPT)
else
	@echo %LINK_OBJS_NAMES% >> $(LINKER_SCRIPT)
endif
	iix chtyp -l LINKER $(LINKER_SCRIPT)
	iix assemble +S $(LINKER_SCRIPT) keep=$@ > debug.map
#	-$(call RMFILES,$(LINKER_SCRIPT))
ifeq ($(EMUCMP),MAME)
	$(SED) '9{:a;N;$$!ba;s/\n/ /g; s/\(\w\+\) . .. .. \(\w\+\)\s*/0x\1 \2\n/g;}' debug.map > temp.map
# Figure out how to get awk to work in cmd.exe - the below only works in sh
	$(AWK) --non-decimal-data 'NR>8 {$$1 += $(MAME_ADDRESS); printf "comadd %x,%s\n", $$1, $$2}' temp.map > debug.map
	-$(call RMFILES,temp.map)
endif

art:
	python .\misc\mkspr.py .\misc\convert.txt .\misc\palette.txt gif src/sprites 1
	
hardware:
	python .\misc\hardware_prep.py

dsk: all 
	-$(call RMFILES,$(DISK))
	$(call CP,$(TEMPLATE_DISK) $(DISK))
	$(CADIUS) ADDFILE $(DISK) /$(VOLUME) ./$(PROGRAM)

floppy: all 
	-$(call RMFILES,$(FLOPPY))
	$(call CP,$(TEMPLATE_FLOPPY) $(FLOPPY))
	$(CADIUS) ADDFILE $(FLOPPY) /$(VOLUME) ./$(PROGRAM)

test: dsk
ifeq ($(EMUCMP),MAME)
	cd $(EMUDIR) && $(EMU) && cd $(mkfile_path)
else
	$(EMUDIR)/$(EMU)
endif

# For all asm files, generate a macro file (if the src contains macros)
macros:
	$(foreach FILE, $(SOURCES), iix macgen $(FILE) $(subst .asm,.mac,$(FILE)) src/macros/macros.s C:/ProgramData/GoldenGate/Libraries/ORCAInclude/m16= C:/ProgramData/GoldenGate/Libraries/ORCAInclude/m16= ${NEWLINE})

# Indent all of the asm files, and globals.s, but not macros.s which has to be LF only (not CRLF which is what cadius will do to it)
indent:
	$(CADIUS) INDENTFILE $(SRCDIR)\*.asm
	$(CADIUS) INDENTFILE $(SRCDIR)\globals.s
# Remove the extra CRLF that CADIUS added, and while at it, remove all trailing blank spaces on lines
	$(SED) -i -e :a -e 's/[[:blank:]]*$$//' -e '/^\n*$$/{$$d;N;ba' -e '}' src/*.asm
	$(SED) -i -e :a -e 's/[[:blank:]]*$$//' -e '/^\n*$$/{$$d;N;ba' -e '}' src/sprites/*.asm
	$(SED) -i -e :a -e 's/[[:blank:]]*$$//' -e '/^\n*$$/{$$d;N;ba' -e '}' src/globals.s

clean:
	-$(call RMFILES,$(TARGETOBJDIR)/sprites/*)
	-$(call RMFILES,$(TARGETOBJDIR)/*.*)
	-$(call RMFILESR,$(LISTINGDIR))
	-$(call RMFILES,$(GIFDIR)/*.*)
	-$(call RMFILESR,$(HARDWAREDIR))
	-$(call RMFILES,$(PROGRAM))
	-$(call RMFILES,$(DISK))
	-$(call RMFILES,$(FLOPPY))
	-$(call RMFILES,$(LINKER_SCRIPT))
	-$(call RMFILES,*.map)

zap: clean
	-$(call RMFILES,$(SRCDIR)/*.mac)
	-$(call RMFILES,$(SRCDIR)/sprites/*.mac)
	-$(call RMDIR,$(TARGETOBJDIR))
	-$(call RMDIR,$(LISTINGDIR))
	-$(call RMDIR,$(GIFDIR))
	-$(call RMDIR,$(HARDWAREDIR))
