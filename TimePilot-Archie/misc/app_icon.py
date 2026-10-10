#!/usr/bin/env python3
"""PNG -> old-format Mode 12, 16-colour RISC OS application sprite.

Header/packing follows the RISC OS sprite PRM.
Input dimensions are preserved; Mode 12 pixels are twice as tall as wide.
"""
from pathlib import Path
import argparse
import struct
from PIL import Image, ImageDraw

# Desktop/Wimp colours; explicit palette keeps conversion reproducible.
PALETTE = [(255,255,255),(221,221,221),(187,187,187),(153,153,153),
           (119,119,119),(85,85,85),(51,51,51),(0,0,0),
           (0,68,153),(238,238,0),(0,204,0),(221,0,0),
           (238,238,187),(85,136,0),(255,187,0),(0,187,255)]
WIDTH, HEIGHT = 34,17

def placeholder(path):
    image=Image.new('RGBA',(WIDTH,HEIGHT),(0,0,0,0))
    d=ImageDraw.Draw(image)
    d.rounded_rectangle((1,1,32,15),radius=3,fill=PALETTE[8]+(255,),outline=PALETTE[15]+(255,))
    # Deliberately simple replaceable aircraft silhouette.
    d.polygon([(5,8),(14,6),(16,3),(19,3),(21,6),(29,8),(21,9),
               (20,12),(16,12),(14,9)],fill=PALETTE[0]+(255,))
    d.rectangle((17,5,19,8),fill=PALETTE[9]+(255,))
    image.save(path)

def encode(image):
    width,height=image.size
    image=image.convert('RGBA')
    row_bytes=((width*4+31)//32)*4
    pixels=bytearray(row_bytes*height)
    mask=bytearray(row_bytes*height)
    for y in range(height):
        for x in range(width):
            r,g,b,a=image.getpixel((x,y))
            colour=min(range(16),key=lambda i:sum((v-c)**2 for v,c in zip((r,g,b),PALETTE[i])))
            byte=y*row_bytes+x//2
            shift=(x%2)*4
            pixels[byte] |= colour << shift
            if a>=128: mask[byte] |= 15 << shift
    palette=b''.join(struct.pack('<II',(b<<24)|(g<<16)|(r<<8),(b<<24)|(g<<16)|(r<<8))
                     for r,g,b in PALETTE)
    image_offset=44+len(palette)
    mask_offset=image_offset+len(pixels)
    sprite_size=mask_offset+len(mask)
    header=struct.pack('<I12s7I',sprite_size,b'!timepilot\0\0',row_bytes//4-1,height-1,
                       0,(width*4-1)%32,image_offset,mask_offset,12)
    # File omits the first word (allocated size) of an in-memory sprite area.
    return struct.pack('<III',1,16,16+sprite_size)+header+palette+pixels+mask

def main():
    root=Path(__file__).resolve().parent.parent
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--input',type=Path,default=root/'misc/app-icon.png')
    p.add_argument('--output',type=Path,default=root/'build/release/!TimePilot/!Sprites,ff9')
    p.add_argument('--placeholder',action='store_true')
    a=p.parse_args()
    if a.placeholder: placeholder(a.input)
    with Image.open(a.input) as image: data=encode(image)
    a.output.parent.mkdir(parents=True,exist_ok=True)
    a.output.write_bytes(data)
    print(a.output)
if __name__=='__main__':main()
