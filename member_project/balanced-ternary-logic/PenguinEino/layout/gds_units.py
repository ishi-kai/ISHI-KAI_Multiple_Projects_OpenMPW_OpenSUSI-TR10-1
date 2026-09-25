"""Write project GDS at 0.001 um DBU without changing physical device dimensions."""
import klayout.db as db

GDS_DBU = .001


def write_gds(layout, target):
    # GDS unit round trips introduce tiny floating point offsets. Normalize
    # these before rescaling so exact half-grid points round consistently.
    layout.dbu = round(layout.dbu, 9)
    opts = db.SaveLayoutOptions()
    opts.dbu = GDS_DBU
    opts.gds2_write_cell_properties = True
    opts.gds2_write_file_properties = True
    layout.write(str(target), opts)
