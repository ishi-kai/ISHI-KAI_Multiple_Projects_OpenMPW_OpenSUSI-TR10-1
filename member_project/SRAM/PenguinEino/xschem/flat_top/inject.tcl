# User-level fix for flat SPICE output with an explicit top .subckt.
# Loaded after Xschem defines netlist; replace only its AWK file selection.
namespace eval ::flat_top {
    variable directory [file dirname [file normalize [info script]]]
}
proc ::flat_top::install {} {
    variable directory
    set awk_file [file join $directory flatten.awk]
    if {![file readable $awk_file]} { error "Flat-top AWK is missing: $awk_file" }
    set body [info body ::netlist]
    set original {set flatten ${XSCHEM_SHAREDIR}/flatten.awk}
    set replacement "set flatten [list $awk_file]"
    if {[string first $replacement $body] >= 0} { return }
    if {[llength [split [string map [list $original \u0001] $body] \u0001]] != 2} {
        error "Xschem netlist procedure changed: flat-top injection not applied"
    }
    proc ::netlist [info args ::netlist] [string map [list $original $replacement] $body]
}
::flat_top::install
