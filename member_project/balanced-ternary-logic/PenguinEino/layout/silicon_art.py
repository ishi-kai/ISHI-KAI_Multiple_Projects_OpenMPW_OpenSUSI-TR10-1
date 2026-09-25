"""Place the original penguin and two-line name as real M2 geometry."""
from pathlib import Path
import klayout.db as db
ROOT=Path(__file__).resolve().parents[1]
FONT={
'E':['11111','10000','10000','11111','10000','10000','11111'],
'I':['11111','00100','00100','00100','00100','00100','11111'],
'N':['11001','11001','11101','10101','10111','10011','10011'],
'O':['11111','10001','10001','10001','10001','10001','11111'],
'S':['11111','10000','10000','11111','00001','00001','11111'],
'U':['10001','10001','10001','10001','10001','10001','11111'],
'K':['10011','10110','11100','11000','11100','10110','10011'],
'A':['01110','11011','10001','11111','10001','10001','10001'],
'Z':['11111','00011','00110','01100','11000','10000','11111']}
def add_art(ly,top):
 old=db.Layout();old.read(str(ROOT/'layout/art/original_inverter_art.gds'))
 art=ly.create_cell('silicon_art');layer=ly.layer(20,0)
 # Scale the 144 x 142 um penguin to 172.8 x 170.4 um.
 source=old.cell('SVG_METAL2_ART')
 for sh in source.shapes(old.layer(20,0)).each():
  poly=sh.polygon.to_dtype(old.dbu).transformed(db.DCplxTrans(1.2,0,False,1625,535.2))
  q=poly.to_itype(.05).to_dtype(.05).to_itype(ly.dbu)
  art.shapes(layer).insert(q)
 for text,y in [('EINOSUKE',666),('OKAZAKI',630)]:
  pixel=4;advance=28;width=(len(text)-1)*advance+5*pixel;left=1625-width/2
  r=db.Region()
  for i,letter in enumerate(text):
   for row,pattern in enumerate(FONT[letter]):
    for col,bit in enumerate(pattern):
     if bit=='1':
      x=left+i*advance+col*pixel;b=y+(6-row)*pixel
      r.insert(db.Box(*(round(v/ly.dbu) for v in [x,b,x+pixel,b+pixel])))
  art.shapes(layer).insert(r.merged())
 top.insert(db.CellInstArray(art.cell_index(),db.Trans()))
