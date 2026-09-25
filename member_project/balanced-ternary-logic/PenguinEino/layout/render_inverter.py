#!/usr/bin/env python3
"""Render the actual saved INV geometry, without loading or regenerating PCells."""
from pathlib import Path
import json
import klayout.db as db
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.path import Path as PlotPath
from matplotlib.patches import PathPatch, Patch, Rectangle

HERE = Path(__file__).resolve().parent
SPECS = [((140, 0), "N-well", "#ccbda1", .55),
         ((3, 1), "P active", "#d1596c", .8),
         ((3, 2), "N active", "#9375b8", .8),
         ((3, 3), "RR active", "#159785", .9),
         ((8, 1), "Gate / RR guard", "#6e9c37", .85),
         ((13, 0), "M1", "#3b87c7", .7),
         ((20, 0), "M2", "#e6a12c", .85),
         ((11, 0), "Contact", "#17334d", .9),
         ((19, 0), "Via", "#a85b19", 1.)]


def main():
    layout = db.Layout()
    layout.read(str(HERE.parent / "inverter.gds"))
    cell = layout.cell("inverter")
    meta = json.loads((HERE / "inverter.ports.json").read_text())
    fig, ax = plt.subplots(figsize=(11, 7.3))
    fig.patch.set_facecolor("#fafbfc")
    ax.set_facecolor("#fafbfc")
    for spec, label, color, alpha in SPECS:
        region = db.Region(cell.begin_shapes_rec(layout.layer(*spec))).merged()
        for poly in region.each():
            vertices, codes = [], []
            loops = [list(poly.each_point_hull())]
            loops += [list(poly.each_point_hole(h)) for h in range(poly.holes())]
            for loop in loops:
                points = [(p.x * layout.dbu, p.y * layout.dbu) for p in loop]
                vertices.extend(points + [points[0]])
                codes.extend([PlotPath.MOVETO] + [PlotPath.LINETO] * (len(points)-1) + [PlotPath.CLOSEPOLY])
            ax.add_patch(PathPatch(PlotPath(vertices, codes), facecolor=color,
                                   edgecolor=color, linewidth=.35, alpha=alpha))
    ax.add_patch(Rectangle((0, 0), 84, 66, fill=False, edgecolor="#516476", lw=.8, linestyle="--"))
    textstyle = dict(fontsize=10, color="#142f47", fontweight="bold",
                     bbox=dict(facecolor="white", edgecolor="none", alpha=.9, pad=2))
    for text, x, y in [("VDD  +5 V", 42, 64.3), ("VSS  −5 V", 42, 1.7),
                       ("vin", 4, 25), ("vout", 80, 38.5)]:
        ax.text(x, y, text, ha="center", va="center", **textstyle)
    for text, x, y in [("PMOS\n13.5 / 1 µm", 14, 38), ("NMOS\n5 / 1 µm", 14, 8),
                       ("RR1  2.8 / 20 µm", 57, 45), ("RR2  2.8 / 20 µm", 57, 32)]:
        ax.text(x, y, text, ha="center", va="center", fontsize=8.5,
                color="#102c41", bbox=dict(facecolor="white", alpha=.8, edgecolor="none", pad=1.5))
    ax.text(60, 59, "RR SUB + guard → VDD", ha="center", fontsize=8.5, color="#31465b")
    ax.set(xlim=(-3, 87), ylim=(-3, 69), xlabel="x [µm]", ylabel="y [µm]")
    ax.set_aspect("equal")
    ax.set_xticks(range(0, 85, 10))
    ax.set_yticks(range(0, 67, 10))
    ax.spines[["top", "right"]].set_visible(False)
    ax.set_title("Balanced ternary INV · 84 × 66 µm\n2 MOS + 2 RR · actual saved GDS", loc="left", fontsize=15, pad=18)
    ax.legend(handles=[Patch(color=color, alpha=alpha, label=label) for _, label, color, alpha in SPECS],
              loc="upper left", bbox_to_anchor=(1.015, 1.), frameon=False, fontsize=9)
    fig.text(.10, .025, "Drawing DRC: 0   |   Strict LVS: match   |   Mask: 0 errors, 1 unconnected-input warning\n"
             "Unchanged two-INV driven fixture: drawing + mask DRC 0, strict LVS match   |   12 µm inter-cell gap",
             fontsize=9, color="#31465b")
    fig.subplots_adjust(left=.09, right=.79, top=.86, bottom=.14)
    fig.savefig(HERE / "inverter.png", dpi=180)
    plt.close(fig)
    print(HERE / "inverter.png")


if __name__ == "__main__":
    main()
