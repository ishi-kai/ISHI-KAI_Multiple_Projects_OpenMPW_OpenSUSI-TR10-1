"""Export full-layout and schematic previews without changing design data."""
import klayout.lay as lay
from common import *


def export_previews(gds, output):
    gds, output = Path(gds), Path(output)
    output.mkdir(parents=True, exist_ok=True)
    schematic = SCHEMATICS/'sram512.sch'
    svg = HERE/'diagrams/sram512.svg'
    report = json.loads((REPORTS/'schematic_previews.json').read_text())
    source = next(v for v in report['views'] if v['schematic'] == schematic.name)
    assert source['schematic_sha256'] == sha(schematic), 'Refresh export_schematics.py first.'
    assert source['image_sha256'] == sha(svg), 'Schematic preview changed after export.'

    view = lay.LayoutView()
    index = view.load_layout(str(gds), False)
    top = view.cellview(index).layout().cell('sram512')
    view.select_cell(top.cell_index(), index)
    layers = PDK/'libs.tech/klayout/tech/TR-1um.lyp'
    view.load_layer_props(str(layers), index, True)
    view.max_hier()
    view.set_config('background-color', '#000000')
    view.set_config('grid-visible', 'false')
    view.set_config('text-visible', 'false')
    box = top.dbbox()
    image_box = box.enlarged(10, 10)
    png = output/'sram512_layout.png'
    view.save_image_with_options(str(png), 3600, 1240, 0, 2, 0, image_box, False)
    schematic_image = output/'sram512_schematic.svg'
    schematic_image.write_bytes(svg.read_bytes())
    return dict(
        layout=dict(source_gds_sha256=sha(gds), top=top.name, bbox_um=str(box),
                    image_box_um=str(image_box), layer_properties_sha256=sha(layers),
                    image=png.name, image_sha256=sha(png), size_pixels=[3600, 1240],
                    renderer='KLayout, full hierarchy; grid and text labels hidden'),
        schematic=dict(source_sch_sha256=sha(schematic), image=schematic_image.name,
                       image_sha256=sha(schematic_image), renderer='Xschem SVG, full top schematic'),
        area=dict(cell_pitch_um=[22.0, 29.6], cell_area_um2=22*29.6,
                  cell_density_bit_per_mm2=1e6/(22*29.6),
                  core_area_mm2=box.width()*box.height()/1e6,
                  core_density_bit_per_mm2=512e6/(box.width()*box.height()),
                  allocation_um=[1800, 600],
                  allocation_use_percent=100*box.width()*box.height()/(1800*600)))
