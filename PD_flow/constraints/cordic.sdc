set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1ns

# Set the current design
current_design cordic

create_clock -name "clk" -add -period 10 -waveform {0 5} [get_ports "clk"]

set_clock_transition -rise 0.1 [get_clocks "clk"]
set_clock_transition -fall 0.1 [get_clocks "clk"]
set_clock_latency -source 0.1 [get_clocks "clk"]

set_max_capacitance 4 [all_inputs]

set_max_fanout 150 [all_inputs]

set_clock_uncertanity 0.1 [get_clocks "clk"]

set_input_delay -clock [get_clocks "clk"] -add_delay 0.05 [get_ports "rst"]

set_wire_load_mode "top"