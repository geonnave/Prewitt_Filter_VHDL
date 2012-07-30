onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /maincontroller_tb/sig_clk
add wave -noupdate -format Logic /maincontroller_tb/sig_sload
add wave -noupdate -format Logic /maincontroller_tb/sig_enable
add wave -noupdate -format Logic /maincontroller_tb/sig_init
add wave -noupdate -format Logic /maincontroller_tb/sig_c_sload
add wave -noupdate -format Literal /maincontroller_tb/sig_count
add wave -noupdate -format Literal /maincontroller_tb/sig_count_i
add wave -noupdate -format Literal /maincontroller_tb/sig_count_j
add wave -noupdate -format Literal -expand /maincontroller_tb/sig_m
add wave -noupdate -format Literal -expand /maincontroller_tb/sig_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {1320960 ps}
