vlog -work work Z:/cgrah064/Documents/ELG4137/Lab2Altera/simulation/modelsim/nand4-input.vwf.vt
vsim -novopt -c -t 1ps -L maxii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.nand4_gate_vlg_vec_tst
onerror {resume}
add wave {nand4_gate_vlg_vec_tst/i1/I1}
add wave {nand4_gate_vlg_vec_tst/i1/I2}
add wave {nand4_gate_vlg_vec_tst/i1/I3}
add wave {nand4_gate_vlg_vec_tst/i1/I4}
add wave {nand4_gate_vlg_vec_tst/i1/O}
run -all
