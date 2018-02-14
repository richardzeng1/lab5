# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns Part1.v

# Load simulation using mux as the top level simulation module.
vsim Part1

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# key 0 for clock 
# SW 1 enable
# sw 0 clear_b



# clock high and clear_b
force {KEY[0]} 0 0, 1 10 -r 20
force {SW[0]} 0

run 60ns

force {KEY[0]} 0 0, 1 10 -r 20
force {SW[1]} 1
force {SW[0]} 1

run 700ns
