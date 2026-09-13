"""Exercise real native Path events in a disposable, unsaved layout."""
import sys
from pathlib import Path
import pya

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'python'))
from path_start_preview import install

app = pya.Application.instance()
try:
    owner = install()
    assert install() is owner
    window = app.main_window()
    cv = window.create_layout(0)
    view = window.current_view()
    layout = cv.layout()
    cell = layout.create_cell('PATH_PREVIEW_TEST')
    cv.cell = cell
    layer = layout.layer(1, 0)
    view.add_missing_layers()
    view.current_layer = view.begin_layers()
    view.zoom_box(pya.DBox(-20, -20, 20, 20))
    view.set_config('edit-grid', '0.5,0.5')
    view.set_config('edit-snap-to-objects', 'false')
    view.set_config('edit-path-width', '2')
    view.switch_mode('path')
    view.send_enter_event()
    plugin = owner.for_view(view)
    left = pya.ButtonState.LeftButton

    def move(x, y):
        view.send_mouse_move_event(pya.DPoint(x, y), 0)

    def click(x, y):
        point = pya.DPoint(x, y)
        view.send_mouse_press_event(point, left)
        view.send_mouse_release_event(point, left)

    move(30, 30)
    assert plugin.box is not None and abs(plugin.box.width() - 2) < 1e-9
    center = plugin.box.center()
    assert abs(center.x * 2 - round(center.x * 2)) < 1e-9
    assert abs(center.y * 2 - round(center.y * 2)) < 1e-9
    assert cell.shapes(layer).size() == 0
    view.set_config('edit-path-width', '3')
    owner.refresh()
    assert abs(plugin.box.width() - 3) < 1e-9
    click(30, 30)
    assert plugin.creating and plugin.box is None
    move(60, 30)
    assert plugin.box is None
    click(60, 30)
    view.send_mouse_double_clicked_event(pya.DPoint(60, 30), left)
    move(70, 30)
    assert not plugin.creating and plugin.box is not None
    assert cell.shapes(layer).size() == 1
    shape = next(cell.shapes(layer).each())
    assert shape.is_path() and abs(shape.dpath.width - 3) < 1e-9
    click(70, 30)
    view.cancel()
    move(75, 30)
    assert not plugin.creating and plugin.box is not None
    assert cell.shapes(layer).size() == 1
    view.switch_mode('box')
    owner.refresh()
    assert plugin.box is None
    view.switch_mode('path')
    owner.refresh()
    assert plugin.box is not None
    owner.action.checked = False
    owner.toggle()
    assert plugin.box is None
    owner.action.checked = True
    owner.toggle()
    assert plugin.box is not None
    view.send_leave_event()
    owner.refresh()
    assert plugin.box is None
    view.send_enter_event()
    move(30, 30)
    assert plugin.box is not None
    view.save_image('/tmp/path-start-preview-smoke.png', 800, 600)
    window.close_current_view()
    owner.refresh()
    print('PASS: native Path creation/cancel, width/grid, tool switch, toggle, leave, view close')
except Exception:
    import traceback
    traceback.print_exc()
    app.exit(1)
else:
    app.exit(0)
