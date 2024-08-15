//-----------------------------------------------------------------------------
// timepilot.r
// Part of Time Pilot, the 1982 arcade game remake
//
// Stefan Wessels, 2024
// This is free and unencumbered software released into the public domain.

#include "Types.r"
#include "Dialogs.r"
#include "MacTypes.r"

// This is the default resource file.  Us the resman.py script to generate tpr.r

// Be sure Rez is called with "-c SWTP". See CMakeLists.txt for details
// Declare my owner ID
type 'SWTP' as 'STR ';

// Make the bundle, linking the icon to this app (Must have FREF as well)
resource 'BNDL'(128, purgeable) {
    'SWTP', 0, {
        'ICN#', {
            0, 128
        },
        'FREF', {
            0, 128
        }
    }
};

// Add an owner version string 
resource 'SWTP'(0, purgeable) {
    "Time Pilot 1.0 by Stefan Wessels, 2024"
};

resource 'FREF'(128, purgeable) {
    'APPL', 0, ""
};

// Add the icon - I did create this using ResEdit
// I grabbed the file from the disk image and used
// resource_dasm to extract a BMP and icns file
// This data is the ICNS file, raw, minus the 
// first 16 bytes.  The second half is the mask where
// the user can click - so all FFs mean anywhere.
data 'ICN#'(128, purgeable) {
    $"0000 0000 FF9F 9300 80A0 F3FC 80E0 4C84"
    $"F0F0 4C84 139C C044 1404 E05C 3404 A0F0"
    $"2404 A0B8 260C E48C 2608 CEBC 2218 6AA0"
    $"2210 2AB8 1E10 7ABC 000F C3C4 0000 007C"
    $"0000 0000 F7B9 EC00 98EF 3FF8 8C64 0C0C"
    $"B644 040C F2E4 0638 F6A4 F520 8CA4 95A0"
    $"8AA4 D4A0 92A4 7490 92E3 8490 9660 8490"
    $"B430 C490 A670 F8F0 E39F 9000 0000 0000"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF" 
    $"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
};

// The contents of the Error Dialog
resource 'DITL' (128, purgeable) {
    {                           // Item list
        {86, 201, 106, 259},    // display rectangle for item
        Button {                // the item is a button
            enabled,            // enable item to return click
            "OK"                // title for button is "OK"
        },    
        { 10, 10, 80, 300 },   // Bounds for static text item
        StaticText {            // Static text item
            disabled,
            "Error"
        }
    }
};

// Defenition of the error dialog
resource 'DLOG' (128, purgeable) {
    { 100, 100, 220, 400 },     // Bounds for the dialog window
    dBoxProc,                   // Standard dialog box procedure
    visible,                    // Initial visibility (invisible when created)
    goAway,                     // Dialog has a close box
    0,
    128,
    "ERROR",
    alertPositionMainScreen     // display on the main screen
};