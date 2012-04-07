onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /mac_signed_tb/sig_a
add wave -noupdate -format Literal /mac_signed_tb/sig_b
add wave -noupdate -format Logic /mac_signed_tb/sig_clk
add wave -noupdate -format Logic /mac_signed_tb/sig_sload
add wave -noupdate -format Literal /mac_signed_tb/sig_accum_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12942 ps} 0}
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
WaveRestoreZoom {0 ps} {128 ns}
