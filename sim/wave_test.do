onerror {resume}
quietly set dataset_list [list vsim1 sim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/tb_top/uart/sys_clk_i
add wave -noupdate sim:/tb_top/uart/periph_clk_i
add wave -noupdate sim:/tb_top/uart/rstn_i
add wave -noupdate sim:/tb_top/uart/uart_rx_i
add wave -noupdate sim:/tb_top/uart/cfg_data_i
add wave -noupdate sim:/tb_top/uart/cfg_addr_i
add wave -noupdate sim:/tb_top/uart/cfg_valid_i
add wave -noupdate sim:/tb_top/uart/cfg_rwn_i
add wave -noupdate sim:/tb_top/uart/cfg_rx_en_i
add wave -noupdate sim:/tb_top/uart/cfg_rx_pending_i
add wave -noupdate sim:/tb_top/uart/cfg_rx_curr_addr_i
add wave -noupdate sim:/tb_top/uart/cfg_rx_bytes_left_i
add wave -noupdate sim:/tb_top/uart/cfg_tx_en_i
add wave -noupdate sim:/tb_top/uart/cfg_tx_pending_i
add wave -noupdate sim:/tb_top/uart/cfg_tx_curr_addr_i
add wave -noupdate sim:/tb_top/uart/cfg_tx_bytes_left_i
add wave -noupdate sim:/tb_top/uart/data_tx_gnt_i
add wave -noupdate sim:/tb_top/uart/data_tx_i
add wave -noupdate sim:/tb_top/uart/data_tx_valid_i
add wave -noupdate sim:/tb_top/uart/data_rx_ready_i
add wave -noupdate sim:/tb_top/uart/uart_tx_o
add wave -noupdate sim:/tb_top/uart/rx_char_event_o
add wave -noupdate sim:/tb_top/uart/err_event_o
add wave -noupdate sim:/tb_top/uart/cfg_ready_o
add wave -noupdate sim:/tb_top/uart/cfg_data_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_startaddr_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_size_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_datasize_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_continuous_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_en_o
add wave -noupdate sim:/tb_top/uart/cfg_rx_clr_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_startaddr_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_size_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_datasize_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_continuous_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_en_o
add wave -noupdate sim:/tb_top/uart/cfg_tx_clr_o
add wave -noupdate sim:/tb_top/uart/data_tx_req_o
add wave -noupdate sim:/tb_top/uart/data_tx_datasize_o
add wave -noupdate sim:/tb_top/uart/data_tx_ready_o
add wave -noupdate sim:/tb_top/uart/data_rx_datasize_o
add wave -noupdate sim:/tb_top/uart/data_rx_o
add wave -noupdate sim:/tb_top/uart/data_rx_valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {84326 ns}
