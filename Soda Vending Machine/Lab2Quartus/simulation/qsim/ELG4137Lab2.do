onerror {quit -f}
vlib work
vlog -work work ELG4137Lab2.vo
vlog -work work ELG4137Lab2.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.bit4_comp_vlg_vec_tst
vcd file -direction ELG4137Lab2.msim.vcd
vcd add -internal bit4_comp_vlg_vec_tst/*
vcd add -internal bit4_comp_vlg_vec_tst/i1/*
add wave /*
run -all
