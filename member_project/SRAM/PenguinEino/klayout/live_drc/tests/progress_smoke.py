"""Run in KLayout: ensure real DRC progress pages never paint during live DRC."""
import sys
from pathlib import Path
import pya

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'python'))
from tr1um_live_drc.controller import install, _hold_layout_display

app = pya.Application.instance()
try:
    window = app.main_window()
    window.show()
    app.process_events()
    stack = next(c for c in window.children() if c.objectName == 'main_stack')
    progress = stack.widget(1)
    changes = []

    def changed(index):
        if index == 1:
            changes.append(bool(progress.updatesEnabled))
            # Give Qt a chance to paint even if the check is very fast.
            progress.repaint()
            app.process_events()

    stack.currentChanged(changed)
    # Positive control: an ordinary progress report really can paint.
    baseline = pya.AbstractProgress('Progress regression control')
    baseline._destroy()
    assert changes == [True], changes
    changes.clear()

    controller = install()
    controller.run_official_now(force=True)
    assert controller._official_rdb is not None
    first_count = controller._official_rdb.num_items()
    controller.run_official_now(force=True)
    assert controller._official_rdb.num_items() == first_count
    assert changes and not any(changes), changes
    assert window.updatesEnabled and stack.currentIndex == 0

    # Exceptions and preexisting disabled painting must restore exact state.
    try:
        with _hold_layout_display(window):
            report = pya.AbstractProgress('Failing progress regression control')
            report._destroy()
            raise RuntimeError('expected test exception')
    except RuntimeError:
        pass
    assert window.updatesEnabled
    window.setUpdatesEnabled(False)
    with _hold_layout_display(window):
        pass
    assert not window.updatesEnabled
    window.setUpdatesEnabled(True)
    assert not any(changes), changes
    controller.shutdown()
    print('PASS: normal progress visible; live DRC progress cannot paint; results retained; painting restored')
except Exception:
    import traceback
    traceback.print_exc()
    app.exit(1)
else:
    app.exit(0)
