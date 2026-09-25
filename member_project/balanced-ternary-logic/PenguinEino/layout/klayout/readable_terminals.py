"""Run in KLayout: use a large, fixed screen font. Preserve layer styles."""
import pya

app = pya.Application.instance()
settings = {'text-font': '0', 'default-font-size': '2'}
for key, value in settings.items():
    app.set_config(key, value)
window = app.main_window()
if window is not None:
    for index in range(window.views()):
        view = window.view(index)
        for key, value in settings.items():
            view.set_config(key, value)
