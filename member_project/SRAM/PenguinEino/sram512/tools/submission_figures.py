"""Submission figures rendered from saved GDS; never modify layout geometry."""
import os
os.environ.setdefault('MPLCONFIGDIR', '/tmp/sram-submission-figures')
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from matplotlib.patches import Polygon, Rectangle, Circle
import klayout.lay as lay
from common import *


TRIALS = [
    ('hand', 'learning/layout/sram.gds', 'sram_array', None, None),
    ('branches', 'klayout/dense_sram/sram_dense.gds', 'sram_dense_2x2',
     'klayout/dense_sram/dimensions.json', 'area_per_bit_um2'),
    ('shared', 'klayout/sram_research/euler_shared.gds', 'euler_shared_2x2',
     'klayout/sram_research/euler_dimensions.json', 'area_per_bit_um2'),
    ('two_wl', 'klayout/sram_t4/t4_dualwl.gds', 't4_dualwl_2x2',
     'klayout/sram_t4/dimensions.json', 'core_area_um2'),
    ('one_wl', 'klayout/sram_t4/t4_singlewl.gds', 't4_singlewl_2x2',
     'klayout/sram_t4/single_dimensions.json', 'core_area_um2'),
    ('compact', 'klayout/sram_compact/compact.gds', 'compact_2x2',
     'klayout/sram_compact/dimensions.json', 'area_per_bit_um2'),
    ('pcell', 'klayout/sram_pcell/pcell.gds', 'pcell_2x2',
     'klayout/sram_pcell/dimensions.json', 'area_per_bit_um2'),
]


def source_files():
    return {ROOT/p for _,gds,_,dimensions,_ in TRIALS for p in (gds,dimensions) if p} | {
        HERE/'layout/ports.json'}


def pin_figure(gds, output):
    layout=db.Layout();layout.read(str(gds));top=layout.cell('sram512')
    region=db.Region(top.begin_shapes_rec(layout.layer(20,0))).merged()
    ports=json.loads((HERE/'layout/ports.json').read_text())
    order=['CLK','RESET','SDI','WE','SDO','VDD','VSS']
    labels=set();iterator=top.begin_shapes_rec(layout.layer(49,0))
    while not iterator.at_end():
        if iterator.shape().is_text():
            t=iterator.shape().text.transformed(iterator.trans())
            labels.add((t.string,t.x,t.y))
        iterator.next()
    verified={}
    for name in order:
        x,y=ports[name]['position_um'];point=db.Point(round(x/layout.dbu),round(y/layout.dbu))
        assert (name,point.x,point.y) in labels, ('Missing GDS port label',name)
        assert any(p.inside(point) for p in region.each()), ('Port is not on M2',name)
        verified[name]=[x,y]

    def metal(ax, bounds):
        x0,y0,x1,y1=bounds
        cut=region & db.Region(db.Box(*(round(v/layout.dbu) for v in bounds)))
        patches=[]
        for poly in cut.each():
            for part in poly.decompose_trapezoids():
                patches.append(Polygon([(p.x*layout.dbu,p.y*layout.dbu) for p in part.each_point()]))
        ax.add_collection(PatchCollection(patches,facecolor='#447da8',edgecolor='none'))
        ax.add_patch(Rectangle((0,0),1776.7,600,fill=False,ec='#515a63',lw=1,ls='--'))
        ax.set_xlim(x0,x1);ax.set_ylim(y0,y1);ax.set_aspect('equal')
        ax.set_facecolor('#f4f7fa');ax.tick_params(labelsize=8)

    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':11})
    fig=plt.figure(figsize=(16,8.1),facecolor='white',layout='constrained')
    grid=fig.add_gridspec(2,7,height_ratios=[2.05,1])
    overview=fig.add_subplot(grid[0,:])
    metal(overview,(-40,-60,1830,665))
    for name,(x,y) in verified.items():
        overview.add_patch(Circle((x,y),9,fill=False,color='#df302c',lw=1.8))
        target=(x,-33) if y<300 else (x+(-52 if name=='VDD' else 18),637)
        overview.annotate(name,(x,y),xytext=target,ha='center',va='center',fontsize=11,
                          arrowprops=dict(arrowstyle='-',color='#df302c',lw=1))
    overview.set_title('SRAM512 external connections — actual Metal 2 (GDS 20/0)',loc='left',weight='bold')
    overview.set_xlabel('x [µm]');overview.set_ylabel('y [µm]')
    for i,name in enumerate(order):
        x,y=verified[name];ax=fig.add_subplot(grid[1,i])
        metal(ax,(x-18,y-18,x+18,y+18))
        ax.add_patch(Circle((x,y),8 if name in ('VDD','VSS') else 5.5,
                            fill=False,color='#df302c',lw=2.4))
        ax.plot(x,y,'+',color='#b31318',markersize=7)
        ax.set_title(name,weight='bold');ax.set_xticks([]);ax.set_yticks([])
        ax.set_xlabel(f'({x:.1f}, {y:.1f}) µm',fontsize=10)
    fig.suptitle('Red circles mark the metal to connect; dashed line is the core boundary',fontsize=12)
    path=output/'sram512_pins.png'
    fig.savefig(path,dpi=180);plt.close(fig)
    return dict(image=path.name,image_sha256=sha(path),source_gds_sha256=sha(gds),
                metal_layer=[20,0],label_layer=[49,0],ports_on_metal_um=verified,
                renderer='GDS polygons drawn with Matplotlib; Metal 2 only, full view and seven details')


def periodic_pitch(layout, cell, key):
    """Measure saved placements, including alternating mirrored rows."""
    top=layout.cell(cell if key=='hand' else cell.replace('_2x2','_4x4'));assert top is not None
    cores={'sram','sram_dense','euler','compact_core','pcell_core',
           't4_core','t4_single_core','t4_shared_via_core'}
    groups={};count=0
    for instance in top.each_inst():
        if instance.cell.name not in cores:
            continue
        for transform in instance.cell_inst.each_cplx_trans():
            groups.setdefault((transform.angle,transform.is_mirror()),[]).append(
                (transform.disp.x*layout.dbu,transform.disp.y*layout.dbu))
            count+=1
    assert count==(4 if key=='hand' else 16),(key,count)
    for points in groups.values():
        xs=sorted({x for x,y in points});ys=sorted({y for x,y in points})
        if len(xs)>1 and len(ys)>1:
            dx=round(min(b-a for a,b in zip(xs,xs[1:])),6)
            dy=round(min(b-a for a,b in zip(ys,ys[1:])),6)
            rows=1 if key in ('hand','two_wl') else 2
            return dict(repeat_x_um=dx,repeat_y_um=dy,rows_per_repeat=rows,
                        measured_area_per_bit_um2=dx*dy/rows,source_cell=top.name)
    raise AssertionError(('No repeated bitcell placement',key))


def trial_figures(output):
    records=[]
    layers=PDK/'libs.tech/klayout/tech/TR-1um.lyp'
    for key,gds,cell,dimensions,area_key in TRIALS:
        view=lay.LayoutView();index=view.load_layout(str(ROOT/gds),False)
        top=view.cellview(index).layout().cell(cell);assert top is not None,cell
        view.select_cell(top.cell_index(),index);view.load_layer_props(str(layers),index,True)
        view.max_hier();view.set_config('background-color','#000000')
        view.set_config('grid-visible','false');view.set_config('text-visible','false')
        box=top.dbbox();cx,cy=box.center().x,box.center().y
        assert box.width()<=160 and box.height()<=120, (key,box)
        path=output/f'cell_{key}.png'
        view.save_image_with_options(str(path),960,720,0,2,0,db.DBox(cx-80,cy-60,cx+80,cy+60),False)
        pitch=periodic_pitch(view.cellview(index).layout(),cell,key)
        area=json.loads((ROOT/dimensions).read_text())[area_key] if dimensions else pitch['measured_area_per_bit_um2']
        assert abs(pitch['measured_area_per_bit_um2']-area)<1e-5,(key,pitch,area)
        records.append(dict(image=path.name,image_sha256=sha(path),source_gds=gds,
            source_gds_sha256=sha(ROOT/gds),cell=cell,shown_bits=4,view_um=[160,120],
            dimensions_source=dimensions,dimensions_sha256=sha(ROOT/dimensions) if dimensions else None,
            cell_area_um2=area,density_bit_per_mm2=1e6/area,placement_pitch=pitch,
            scope='Periodic array area per bit; excludes tap columns, ends and peripheral circuits'))
    return records


def export_figures(gds, output):
    output=Path(output);output.mkdir(parents=True,exist_ok=True)
    return dict(pins=pin_figure(Path(gds),output),layout_trials=trial_figures(output))


if __name__=='__main__':
    write_json(WORK/'submission/figures.json',export_figures(
        ROOT/'submission/sram512.gds',WORK/'submission'))
