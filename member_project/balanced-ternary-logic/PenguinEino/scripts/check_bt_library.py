"""Run in KLayout after startup: require live PCells, no defunct cells, unchanged geometry."""
from pathlib import Path
import hashlib,json,subprocess,tempfile
import pya
ROOT=Path(__file__).resolve().parents[1]
app=pya.Application.instance()
try:
    lib=pya.Library.library_by_name('BT')
    assert lib.layout().technology_name=='TR-1um'
    lib.refresh()
    assert all('defunct' not in c.display_title() for c in lib.layout().each_cell())
    pcells=[c for c in lib.layout().each_cell() if c.is_pcell_variant()]
    assert len(pcells)>=9
    for kind in ('inverter','nany','half_adder'):
        src=pya.Layout();src.technology_name='TR-1um';src.read(str(ROOT/(kind+'.gds')))
        for info in src.layer_infos():
            assert (pya.Region(lib.layout().cell(kind).begin_shapes_rec(lib.layout().layer(info)))^pya.Region(src.cell(kind).begin_shapes_rec(src.layer(info)))).is_empty(),(kind,info)
    ha=lib.layout().cell('half_adder')
    children=[inst.cell.name for inst in ha.each_inst()]
    assert children.count('inverter')==2 and children.count('nany')==5,children
    assert len(children)==7
    assert not any(c.library_name()=='BT' for c in lib.layout().each_cell()),'Recursive BT proxy'
    # Place the new macro in a parent and refresh it, as the future FA will do.
    parent=pya.Layout();parent.dbu=.001;parent.technology_name='TR-1um'
    top=parent.create_cell('library_test_parent')
    proxy=parent.cell(parent.add_lib_cell(lib,ha.cell_index()))
    top.insert(pya.CellInstArray(proxy.cell_index(),pya.Trans()))
    assert proxy.library_name()=='BT' and proxy.library_cell_name()=='half_adder'
    lib.refresh()
    assert all('defunct' not in c.display_title() for c in parent.each_cell())
    for info in lib.layout().layer_infos():
        assert (pya.Region(top.begin_shapes_rec(parent.layer(info)))^pya.Region(lib.layout().cell('half_adder').begin_shapes_rec(lib.layout().layer(info)))).is_empty(),str(info)
    cv=app.main_window().load_layout(str(ROOT/'half_adder.gds'),0)
    assert all('defunct' not in c.display_title() for c in cv.layout().each_cell())
    # Load/save in a separate process with no libraries, removing only KLayout context metadata.
    with tempfile.TemporaryDirectory() as directory:
        snapshot=Path(directory)/'literal.gds'
        code="""import klayout.db as db,sys
l=db.Layout();l.read(sys.argv[1]);assert not db.Library.library_names()
o=db.SaveLayoutOptions();o.write_context_info=False;l.write(sys.argv[2],o)
"""
        subprocess.run(['python3','-c',code,str(ROOT/'half_adder.gds'),str(snapshot)],check=True)
        literal=pya.Layout();literal.read(str(snapshot))
        # A delivered parent GDS must also work in a process without any libraries.
        delivered=Path(directory)/'parent.gds';parent.write(str(delivered))
        flattened_context=Path(directory)/'parent_no_library.gds'
        subprocess.run(['python3','-c',code,str(delivered),str(flattened_context)],check=True)
        standalone=pya.Layout();standalone.read(str(flattened_context))
        for info in literal.layer_infos():
            assert (pya.Region(standalone.cell('library_test_parent').begin_shapes_rec(standalone.layer(info)))^pya.Region(literal.cell('half_adder').begin_shapes_rec(literal.layer(info)))).is_empty(),str(info)
    for info in literal.layer_infos():
        assert (pya.Region(cv.layout().cell('half_adder').begin_shapes_rec(cv.layout().layer(info)))^pya.Region(literal.cell('half_adder').begin_shapes_rec(literal.layer(info)))).is_empty(),str(info)
    result=dict(passed=True,technology=lib.layout().technology_name,registered_cells=['inverter','nany','half_adder'],live_pcell_variants=len(pcells),defunct_cells=0,primitive_geometry_match=True,half_adder_geometry_match=True,half_adder_shared_children={'inverter':2,'nany':5},parent_instantiation=True,standalone_parent_geometry_match=True,refresh_test=True,gds_sha256=hashlib.sha256((ROOT/'half_adder.gds').read_bytes()).hexdigest())
    (ROOT/'reports/bt_library.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)
    app.exit(0)
except Exception:
    import traceback;traceback.print_exc();app.exit(1)
