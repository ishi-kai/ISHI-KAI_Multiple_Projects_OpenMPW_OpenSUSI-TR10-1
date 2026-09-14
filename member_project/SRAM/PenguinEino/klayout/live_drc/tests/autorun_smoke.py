"""Verify that the installed .lym macro is discovered automatically."""

import builtins


key = "_tr1um_live_drc_controller"
assert hasattr(builtins, key), "TR-1um Live DRC autorun macro was not loaded"
controller = getattr(builtins, key)
print("Autorun smoke test: macro discovered")
controller.shutdown()
