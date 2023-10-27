set search_path "/afs/iitd.ac.in/service/tools/public/asiclib/umcoa/L65/libraries/UMC65LLSC/synopsys/ccs"
set_attribute lib_search_path "/afs/iitd.ac.in/service/tools/public/asiclib/umcoa/L65/libraries/UMC65LLSC/synopsys/ccs/"

set_attribute hdl_search_path "/afs/iitd.ac.in/user/j/jv/jvl232241/umc65/PD_flow/Cordic/rtl/"
set_attribute library "uk65lscllmvbbr_100c25_tc_ccs.lib"

read_hdl cordic_pipelined.v
read_hdl lut.v
 
elaborate 
check_design -unresolved
read_sdc ~/umc65/PD_flow/Cordic/constraints/cordic.sdc
synthesize -to_mapped -effort high
write_hdl > /afs/iitd.ac.in/user/j/jv/jvl232241/umc65/PD_flow/Cordic/typical/synth_typical.v
write_sdc > /afs/iitd.ac.in/user/j/jv/jvl232241/umc65/PD_flow/Cordic/typical/sdc_typical.sdc