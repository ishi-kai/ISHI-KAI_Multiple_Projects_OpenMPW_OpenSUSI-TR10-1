"""Render the saved submission GDS and verify every displayed connection point."""
import os
os.environ.setdefault('QT_QPA_PLATFORM','offscreen')
os.environ.setdefault('MPLCONFIGDIR','/tmp/ternary-submission-mpl')
from pathlib import Path
import json,hashlib
import klayout.db as db
import klayout.lay as lay
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from matplotlib.patches import Polygon,Rectangle
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'submission';PDK=Path('/home/ishi-kai/pdk/TR-1um')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def main():
 gds=OUT/'mac.gds';view=lay.LayoutView();i=view.load_layout(str(gds),False)
 layout=view.cellview(i).layout();top=layout.cell('mac');view.select_cell(top.cell_index(),i)
 view.load_layer_props(str(PDK/'libs.tech/klayout/tech/TR-1um.lyp'),i,True);view.max_hier()
 view.set_config('background-color','#000000');view.set_config('grid-visible','false');view.set_config('text-visible','false')
 view.save_image_with_options(str(OUT/'mac_layout.png'),3200,1450,0,2,0,top.dbbox().enlarged(15,15),False)
 ports=json.loads((ROOT/'layout/mac.ports.json').read_text())['ports']
 regions={layer:db.Region(top.begin_shapes_rec(layout.layer(layer,0))).merged() for layer in (13,20)}
 for name,p in ports.items():
  x,y=p['position_um'];pt=db.Point(round(x/layout.dbu),round(y/layout.dbu))
  assert any(poly.inside(pt) for poly in regions[p['layer'][0]].each()),name
  assert any(s.is_text() and s.text.string==name and s.text.x==pt.x and s.text.y==pt.y for s in top.shapes(layout.layer(*p['label_layer'])).each()),name
 def draw(ax,bounds):
  for layer,color in ((13,'#477cab'),(20,'#c89434')):
   cut=regions[layer]&db.Region(db.Box(*(round(v/layout.dbu) for v in bounds)))
   patches=[]
   for poly in cut.each():
    for part in poly.decompose_trapezoids():patches.append(Polygon([(p.x*layout.dbu,p.y*layout.dbu) for p in part.each_point()]))
   ax.add_collection(PatchCollection(patches,facecolor=color,edgecolor='none'))
  ax.set_xlim(bounds[0],bounds[2]);ax.set_ylim(bounds[1],bounds[3]);ax.set_aspect('equal');ax.set_facecolor('#f5f7fa');ax.tick_params(labelsize=8)
 plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
 fig=plt.figure(figsize=(17,12),facecolor='white',layout='constrained');grid=fig.add_gridspec(3,6,height_ratios=[3.5,1,1]);ax=fig.add_subplot(grid[0,:])
 draw(ax,(-130,-50,1870,1040));ax.add_patch(Rectangle((0,0),1800,1000,fill=False,ec='#777',ls='--',lw=1))
 labels={'VDD':(1835,805),'VSS':(1835,418.2),'VMID':(-70,820),'a':(-70,500),'b':(-70,555),'x':(-70,450),'cin':(-70,400),'and_out':(1835,745),'or_out':(1835,670),'sum':(1835,201.3),'cout':(1835,64.1)}
 for name,p in ports.items():
  x,y=p['position_um'];ax.plot(x,y,'o',mfc='none',mec='#d52d38',ms=9,mew=1.5)
  ax.annotate(name,(x,y),xytext=labels[name],ha='center',va='center',fontsize=11,color='#96202a',arrowprops={'arrowstyle':'-','color':'#d52d38','lw':1})
 ax.set_title('MAC connections on actual GDS metal | blue: M1 (13/0), gold: M2 (20/0)',loc='left',weight='bold');ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]')
 order=('VDD','VMID','VSS','a','b','x','cin','sum','cout','and_out','or_out')
 for i,name in enumerate(order):
  ax=fig.add_subplot(grid[1+i//6,i%6]);p=ports[name];x,y=p['position_um'];draw(ax,(x-12,y-12,x+12,y+12))
  ax.plot(x,y,'o',mfc='none',mec='#d52d38',ms=24,mew=2);ax.plot(x,y,'+',color='#ab1726',ms=10)
  ax.set_title(name,weight='bold');ax.set_xticks([]);ax.set_yticks([]);layer='M1' if p['layer']==[13,0] else 'M2';ax.set_xlabel(f'{layer} · ({x:g}, {y:g}) µm',fontsize=9)
 ax=fig.add_subplot(grid[2,5]);ax.axis('off');ax.text(.05,.65,'Red marker: connect here\nDashed box: 1800 × 1000 µm\n\nCoordinates use the GDS origin.\nNo pad frame included.',va='top',linespacing=1.8)
 fig.savefig(OUT/'mac_pins.png',dpi=180);plt.close(fig)
 report=dict(passed=True,gds_sha256=sha(gds),pins_verified_on_metal=ports,images={n:sha(OUT/n) for n in ('mac_layout.png','mac_pins.png','mac_schematic.svg')})
 (ROOT/'reports/submission_figures.json').write_text(json.dumps(report,indent=2)+'\n');print('Rendered and verified submission figures')
if __name__=='__main__':main()
