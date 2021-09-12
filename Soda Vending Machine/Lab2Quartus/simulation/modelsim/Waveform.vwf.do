vlog -work work Z:/cgrah064/Documents/ELG4137/Lab2Altera/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L maxii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.FULL_ADDER_vlg_vec_tst
onerror {resume}
add wave {FULL_ADDER_vlg_vec_tst/i1/A}
add wave {FULL_ADDER_vlg_vec_tst/i1/B}
add wave {FULL_ADDER_vlg_vec_tst/i1/Cin}
add wave {FULL_ADDER_vlg_vec_tst/i1/Cout}
add wave {FULL_ADDER_vlg_vec_tst/i1/Sum}
run -all
