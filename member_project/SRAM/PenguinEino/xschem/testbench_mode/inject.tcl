# Apply simulation settings BEFORE the C netlister reads its top-level flags.
# netlist_options alone is too late for top_is_subckt in Xschem 3.4.8RC.
namespace eval ::sram_tb_mode {
    variable saved {}
    variable project [file normalize [file join [file dirname [info script]] ../..]]
}
proc ::sram_tb_mode::enter {command operation} {
    if {[lindex $command 1] ne "netlist"} { return }
    variable saved
    set saved {}
    variable project
    set path [file normalize [xschem get current_name]]
    if {[file dirname $path] ne $project} { return }
    set name [file tail $path]
    if {![string match sram_tb*.sch $name]} { return }
    foreach {key value} {lvs_netlist 0 top_is_subckt 0 spiceprefix 1 flat_netlist 0} {
        dict set saved $key [set ::$key]
        set ::$key $value
    }
    xschem set flat_netlist 0
}
proc ::sram_tb_mode::leave {command code result operation} {
    if {[lindex $command 1] ne "netlist"} { return }
    variable saved
    dict for {key value} $saved { set ::$key $value }
    if {[dict exists $saved flat_netlist]} {
        xschem set flat_netlist [dict get $saved flat_netlist]
    }
    set saved {}
}
catch {trace remove execution ::xschem enter ::sram_tb_mode::enter}
catch {trace remove execution ::xschem leave ::sram_tb_mode::leave}
trace add execution ::xschem enter ::sram_tb_mode::enter
trace add execution ::xschem leave ::sram_tb_mode::leave
