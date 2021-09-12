onerror {quit -f}
vlib work
vlog -work work ELG4137Project.vo
vlog -work work ELG4137Project.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.vendMachine_vlg_vec_tst
vcd file -direction ELG4137Project.msim.vcd
vcd add -internal vendMachine_vlg_vec_tst/*
vcd add -internal vendMachine_vlg_vec_tst/i1/*
add wave /*
run -all
