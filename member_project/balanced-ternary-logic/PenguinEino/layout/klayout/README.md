# KLayout terminal-label display

User preference: preserve original PDK layer colors and styles.
TXM1 (48/0) is original blue #0080ff; TXM2 (49/0) is original gray #c0c0c0.
The earlier yellow/cyan colors and line-width changes were reverted.
Only text-font=0 (Default fixed screen font) and default-font-size=2 (Large)
are customized. The installed startup/menu macro no longer changes any colors.

Installed files:
- Active PDK TR-1um.lyp: terminal-layer styles restored to their original values.
- ~/.klayout/klayoutrc: fixed font settings.
- ~/.klayout/macros/readable_terminals.lym: fixed font startup/menu action.

Save work and restart KLayout to load the persisted styles and font settings.
Existing running windows have not been remotely updated.
Original files are backed up under layout/backups/.
TR-1um-readable.lyp now contains the restored PDK styles.

# BT library and nested PCells

One library, `BT`, exposes `inverter`, `nany`, and `half_adder`. The canonical editable
sources remain the project-root GDS files. File → Refresh Libraries rereads all
three files in dependency order: inverter → nany → half_adder.
BT copies are included in saved parent GDS files, so layout delivery does not
require the registration macro.

Registration uses `bt_library_context.lym`, installed at
`~/.klayout/macros/bt_library_context.lym`. The macro runs after the PDK's startup
macro (priority 100 vs 0), sets the library/source layouts' technology to TR-1um,
and preserves the nested live PCell variants while importing the sources.
HA references to BT primitives are mapped to the already loaded cells inside BT,
including cold proxies encountered before BT is registered at startup. This keeps
HA → primitive → PCell hierarchy without duplicate primitive copies or circular
BT library references.
Its Python implementation is mirrored in `bt_library_context.py`.

The earlier two `define("BT", ...)` declarations in `~/.klayout/klayout.lib`
were removed. KLayout's file-library loader left the library layout technology
empty; TR-1um's PCells are registered only for technology TR-1um. That caused the
first imported GDS's nested PCell references to become `<defunct>` despite their
saved shapes remaining present. In addition, the loader's multi-file merge copied
the later file's children as static geometry. The new registration keeps both
primitives' nested PCells live instead of just removing their context metadata.

Save existing GUI work and restart KLayout to apply the installed registration.
Alternatively open the updated `bt_library_context.lym` from disk and run it in
the macro editor. Its menu description is **Register / Reload BT cells**.
The already running process may still hold the previous macro code; merely using
Refresh Libraries does not install a changed Python registration function. It replaces the
BT library registration and updates its linked instances. It does not change
primitive GDS files, the saved HA GDS, display colors, or device dimensions.

Validation in a fresh GUI process and after Refresh Libraries:
- 12 live PCell variants; zero `<defunct>` cells in BT or the loaded HA.
- Source primitive, registered HA, and saved HA geometry compare identically on every layer.
- Registered HA shares two INV and five NANY instances with the primitive cells in BT.
- Placing HA into a parent, refreshing, and saving/reopening that parent without
  installed libraries preserves its geometry.
- Previously verified HA: default GUI Drawing DRC 0, strict LVS Match.
  Registration changes leave all source GDS files unchanged.
See `reports/bt_library.json` and `reports/half_adder_gui.json`.

Recheck with:

```sh
QT_QPA_PLATFORM=offscreen klayout -z -t -r scripts/check_bt_library.py
```

For a new environment, install the TR-1um PDK and copy this macro into
`~/.klayout/macros/`. Update its ROOT path if the project resides elsewhere.
This is needed for editable, refreshable library references, not for reading
the delivered GDS geometry.

# Local editing of a library instance

Select the placed instance in the drawing, then Edit → Selection → Convert To Static Cell.
This creates a static cell and retargets the selected instance. Descend into that
cell to edit it. The original library file and other unconverted instances retain
their links. The converted instance no longer receives library updates.
If an array is selected, its elements share the converted cell.

The separate Edit → Cell → Convert Cell To Static command (with a cell selected
in the Cells tree) retargets all instances of that cell in the layout.

# Registering another cell

The startup macro is a Python subclass of `pya.Library`. `reload()` reads each
GDS named in `CELLS`, copies its hierarchy while preserving PCells, and
`self.register('BT')` registers the resulting library with KLayout.

The implementation in `bt_library_context.py` is also embedded in the `.lym`
file's `<text>` element. When changing it, keep these two copies synchronized
and install the updated `.lym` in `~/.klayout/macros/`. A `.lib` file is not used.

For example, HA was added with:

```python
CELLS=('inverter','nany','half_adder')
```

Place its instance using **Instance → Library: BT → Cell: half_adder**.
Use magnification 1 and a parent DBU of 0.001 µm. After editing and saving
`half_adder.gds`, use **File → Refresh Libraries** to update linked instances.
