#!/usr/bin/env python3
"""Package game, icon and THSound with its documentation/licence.

Outputs a HostFS transport ZIP and a native ZIP with Acorn file metadata.
"""
from pathlib import Path
from datetime import datetime, timezone
import hashlib
import shutil
import struct
import zipfile
from PIL import Image
from app_icon import encode

root = Path(__file__).resolve().parent.parent
output = root / 'build/release'
app = output / '!TimePilot'
app.mkdir(parents=True, exist_ok=True)
shutil.copy2(root / 'build/tpilot,ff8', app / '!RunImage,ff8')
boot='Set TimePilot$Dir <Obey$Dir>\nIconSprites <TimePilot$Dir>.!Sprites\n'
(app / '!Boot,feb').write_text(boot)
(app / '!Run,feb').write_text(boot+'RMEnsure THSound 2.20 RMLoad <Obey$Dir>.THSound\nWimpSlot -min 640K\n<TimePilot$Dir>.!RunImage\n')
(app / 'Silent,feb').write_text(boot+'WimpSlot -min 640K\n<TimePilot$Dir>.!RunImage --silent\n')
with Image.open(root / 'misc/app-icon.png') as icon:
    (app / '!Sprites,ff9').write_bytes(encode(icon))
source = root / 'third_party/THSound/THS221.zip'
with zipfile.ZipFile(source) as archive:
    module = archive.read('!System/310/Modules/Audio/THSound')
    (app / 'THSound,ffa').write_bytes(module)
    (app / 'COPYING,fff').write_bytes(archive.read('COPYING'))
    (app / 'THSHelp,fff').write_bytes(archive.read('!Help'))
# Remove the archive left by earlier packaging runs.
(app / 'THS221,ddc').unlink(missing_ok=True)
(app / 'THSNotice,fff').write_text('THSound by Tony Houghton, GPL v2. Unmodified module.\n'
    'Licence: COPYING. Original documentation: THSHelp.\n'
    'Distribution labelled 2.21; module header reports 2.20 (04 Jul 2003).\n')
# Remove the README left by earlier packaging runs.
(app / 'ReadMe,fff').unlink(missing_ok=True)
files = sorted(p for p in app.iterdir() if p.is_file())
(output / 'SHA256.txt').write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  !TimePilot/'+p.name+'\n' for p in files))
with zipfile.ZipFile(output / 'TimePilot-HostFS.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
    for path in files: archive.write(path, path.relative_to(output))
    archive.write(output / 'SHA256.txt', 'SHA256.txt')

# Acorn ZIP extra field 0x4341: ARC0, load/exec addresses, attributes, reserved.
# Native files omit HostFS comma suffixes; extraction restores file types.
with zipfile.ZipFile(output / 'TimePilot-RISCOS.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
    for path in files:
        name, file_type = path.name.rsplit(',',1)
        cs = int((path.stat().st_mtime + 2208988800)*100)
        load = 0xfff00000 | (int(file_type,16)<<8) | ((cs>>32)&255)
        assert ((load >> 8) & 0xfff) == int(file_type,16)
        info = zipfile.ZipInfo('!TimePilot/'+name, datetime.fromtimestamp(path.stat().st_mtime,timezone.utc).timetuple()[:6])
        info.compress_type = zipfile.ZIP_DEFLATED
        info.extra = struct.pack('<HH4sIIII',0x4341,20,b'ARC0',load,cs&0xffffffff,3,0)
        archive.writestr(info,path.read_bytes())
print(output / 'TimePilot-HostFS.zip')
print(output / 'TimePilot-RISCOS.zip')
