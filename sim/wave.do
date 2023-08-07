onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /manual_data_send/uart/sys_clk_i
add wave -noupdate /manual_data_send/uart/periph_clk_i
add wave -noupdate /manual_data_send/uart/rstn_i
add wave -noupdate /manual_data_send/uart/uart_rx_i
add wave -noupdate /manual_data_send/uart/cfg_data_i
add wave -noupdate /manual_data_send/uart/cfg_addr_i
add wave -noupdate /manual_data_send/uart/cfg_valid_i
add wave -noupdate /manual_data_send/uart/cfg_rwn_i
add wave -noupdate /manual_data_send/uart/cfg_rx_en_i
add wave -noupdate /manual_data_send/uart/cfg_rx_pending_i
add wave -noupdate /manual_data_send/uart/cfg_rx_curr_addr_i
add wave -noupdate /manual_data_send/uart/cfg_rx_bytes_left_i
add wave -noupdate /manual_data_send/uart/cfg_tx_en_i
add wave -noupdate /manual_data_send/uart/cfg_tx_pending_i
add wave -noupdate /manual_data_send/uart/cfg_tx_curr_addr_i
add wave -noupdate /manual_data_send/uart/cfg_tx_bytes_left_i
add wave -noupdate /manual_data_send/uart/data_tx_gnt_i
add wave -noupdate /manual_data_send/uart/data_tx_i
add wave -noupdate /manual_data_send/uart/data_tx_valid_i
add wave -noupdate /manual_data_send/uart/data_rx_ready_i
add wave -noupdate /manual_data_send/uart/uart_tx_o
add wave -noupdate /manual_data_send/uart/rx_char_event_o
add wave -noupdate /manual_data_send/uart/err_event_o
add wave -noupdate /manual_data_send/uart/cfg_ready_o
add wave -noupdate /manual_data_send/uart/cfg_data_o
add wave -noupdate /manual_data_send/uart/cfg_rx_startaddr_o
add wave -noupdate /manual_data_send/uart/cfg_rx_size_o
add wave -noupdate /manual_data_send/uart/cfg_rx_datasize_o
add wave -noupdate /manual_data_send/uart/cfg_rx_continuous_o
add wave -noupdate /manual_data_send/uart/cfg_rx_en_o
add wave -noupdate /manual_data_send/uart/cfg_rx_clr_o
add wave -noupdate /manual_data_send/uart/cfg_tx_startaddr_o
add wave -noupdate /manual_data_send/uart/cfg_tx_size_o
add wave -noupdate /manual_data_send/uart/cfg_tx_datasize_o
add wave -noupdate /manual_data_send/uart/cfg_tx_continuous_o
add wave -noupdate /manual_data_send/uart/cfg_tx_en_o
add wave -noupdate /manual_data_send/uart/cfg_tx_clr_o
add wave -noupdate /manual_data_send/uart/data_tx_req_o
add wave -noupdate /manual_data_send/uart/data_tx_datasize_o
add wave -noupdate /manual_data_send/uart/data_tx_ready_o
add wave -noupdate /manual_data_send/uart/data_rx_datasize_o
add wave -noupdate /manual_data_send/uart/data_rx_o
add wave -noupdate /manual_data_send/uart/data_rx_valid_o
add wave -noupdate -divider register
add wave -noupdate /manual_data_send/uart/s_uart_status
add wave -noupdate /manual_data_send/uart/s_uart_stop_bits
add wave -noupdate /manual_data_send/uart/s_uart_parity_en
add wave -noupdate /manual_data_send/uart/s_uart_div
add wave -noupdate /manual_data_send/uart/s_uart_bits
add wave -noupdate /manual_data_send/uart/s_uart_rx_clean_fifo
add wave -noupdate /manual_data_send/uart/s_uart_rx_polling_en
add wave -noupdate /manual_data_send/uart/s_uart_rx_irq_en
add wave -noupdate /manual_data_send/uart/s_uart_err_irq_en
add wave -noupdate /manual_data_send/uart/s_uart_en_rx
add wave -noupdate /manual_data_send/uart/s_uart_en_tx
add wave -noupdate /manual_data_send/uart/s_data_rx_ready_mux
add wave -noupdate /manual_data_send/uart/s_data_rx_ready
add wave -noupdate /manual_data_send/uart/s_data_tx_valid
add wave -noupdate /manual_data_send/uart/s_data_tx_ready
add wave -noupdate /manual_data_send/uart/s_data_tx
add wave -noupdate /manual_data_send/uart/s_data_tx_dc_valid
add wave -noupdate /manual_data_send/uart/s_data_tx_dc_ready
add wave -noupdate /manual_data_send/uart/s_data_tx_dc
add wave -noupdate /manual_data_send/uart/s_data_rx_dc_valid
add wave -noupdate /manual_data_send/uart/s_data_rx_dc_ready
add wave -noupdate /manual_data_send/uart/s_data_rx_dc
add wave -noupdate /manual_data_send/uart/r_uart_stop_bits
add wave -noupdate /manual_data_send/uart/r_uart_parity_en
add wave -noupdate /manual_data_send/uart/r_uart_div
add wave -noupdate /manual_data_send/uart/r_uart_bits
add wave -noupdate /manual_data_send/uart/r_uart_en_rx_sync
add wave -noupdate /manual_data_send/uart/r_uart_en_tx_sync
add wave -noupdate /manual_data_send/uart/s_uart_tx_sample
add wave -noupdate /manual_data_send/uart/s_uart_rx_sample
add wave -noupdate /manual_data_send/uart/r_status_sync
add wave -noupdate /manual_data_send/uart/s_err_rx_overflow
add wave -noupdate /manual_data_send/uart/s_err_rx_overflow_sync
add wave -noupdate /manual_data_send/uart/s_err_rx_parity
add wave -noupdate /manual_data_send/uart/s_err_rx_parity_sync
add wave -noupdate /manual_data_send/uart/s_rx_char_event
add wave -noupdate /manual_data_send/uart/s_rx_char_event_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {1 us}
