"""Represent column access wiring around the common AND2 standard cell.

The column gates add field-GC contacts to a verified standard cell. Keeping
that standard cell as a child gives the schematic and layout the same gate
hierarchy. Every fabrication polygon is preserved exactly; no compare rule,
device abstraction, port, or checking deck is changed.
"""
from common import *

def column_gate_wrappers(layout,top):
    base=layout.cell('AND2_X1');assert base is not None
    layers=[i for i in layout.layer_indexes() if layout.get_info(i).layer not in (48,49)]
    before={i:db.Region(top.begin_shapes_rec(i)) for i in layers}
    changed=[]
    for cell in list(layout.each_cell()):
        if not cell.name.startswith('AND2_X1$'):continue
        additions={}
        for i in layers:
            original=db.Region(base.begin_shapes_rec(i));modified=db.Region(cell.begin_shapes_rec(i))
            assert (original-modified).is_empty(),(cell.name,layout.get_info(i),'not an additive access variant')
            additions[i]=modified-original
        labels=[(i,s.text) for i in layout.layer_indexes() for s in cell.shapes(i).each() if s.is_text()]
        old_name=cell.name
        cell.clear();cell.name='AND2_COLUMN_ACCESS'
        cell.insert(db.CellInstArray(base.cell_index(),db.Trans()))
        for i,region in additions.items():cell.shapes(i).insert(region)
        for i,label in labels:cell.shapes(i).insert(label)
        changed.append(dict(original_name=old_name,name=cell.name,base=base.name))
    assert changed,'No column access variants were found.'
    for i,region in before.items():
        assert (region^db.Region(top.begin_shapes_rec(i))).is_empty(),('fabrication geometry changed',layout.get_info(i))
    return dict(changed_cells=changed,fabrication_geometry_xor_empty=True,
                scope='Common verified AND2 child plus its existing physical access wiring.')
