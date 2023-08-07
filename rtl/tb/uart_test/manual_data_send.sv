/////////////////////////////////////////////////////////////////////////////////////
//
// This is for only learn about uart protocal of pulp
//
//////////////////////////////////////////////////////////////////////////////////////////

module manual_data_send();
    localparam L2_AWIDTH_NOAL = 12;
    localparam TRANS_SIZE     = 16;

    logic                      sys_clk_i    = 1'b0;
    logic                      periph_clk_i = 1'b0;
    logic   	               rstn_i;

	logic                      uart_rx_i;
	logic                      uart_tx_o;

    logic                      rx_char_event_o;
    logic                      err_event_o;

	logic               [31:0] cfg_data_i;
    logic                [4:0] cfg_addr_i;
	logic                      cfg_valid_i;
	logic                      cfg_rwn_i;
	logic                      cfg_ready_o;
    logic               [31:0] cfg_data_o;

    logic [L2_AWIDTH_NOAL-1:0] cfg_rx_startaddr_o;
    logic     [TRANS_SIZE-1:0] cfg_rx_size_o;
    logic                [1:0] cfg_rx_datasize_o;
    logic                      cfg_rx_continuous_o;
    logic                      cfg_rx_en_o;
    logic                      cfg_rx_clr_o;
    logic                      cfg_rx_en_i;
    logic                      cfg_rx_pending_i;
    logic [L2_AWIDTH_NOAL-1:0] cfg_rx_curr_addr_i;
    logic     [TRANS_SIZE-1:0] cfg_rx_bytes_left_i;

    logic [L2_AWIDTH_NOAL-1:0] cfg_tx_startaddr_o;
    logic     [TRANS_SIZE-1:0] cfg_tx_size_o;
    logic                [1:0] cfg_tx_datasize_o;
    logic                      cfg_tx_continuous_o;
    logic                      cfg_tx_en_o;
    logic                      cfg_tx_clr_o;
    logic                      cfg_tx_en_i;
    logic                      cfg_tx_pending_i;
    logic [L2_AWIDTH_NOAL-1:0] cfg_tx_curr_addr_i;
    logic     [TRANS_SIZE-1:0] cfg_tx_bytes_left_i;

    logic                      data_tx_req_o;
    logic                      data_tx_gnt_i;
    logic                [1:0] data_tx_datasize_o;
    logic               [31:0] data_tx_i;
    logic                      data_tx_valid_i;
    logic                      data_tx_ready_o;
             
    logic                [1:0] data_rx_datasize_o;
    logic               [31:0] data_rx_o;
    logic                      data_rx_valid_o;
    logic                      data_rx_ready_i;

    udma_uart_top #(
        .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
        .TRANS_SIZE(TRANS_SIZE)
    ) uart (
        .*
    );

    always begin
        #10 periph_clk_i <= ~periph_clk_i; 
    end
    always begin
        #10 sys_clk_i    <= ~sys_clk_i;
    end
    initial begin
        uart_rx_i           = 1'b0;
        rstn_i              = 1'b1;

        cfg_data_i          = 2'h00;
        cfg_addr_i          = 4'b0000;
        cfg_valid_i         = 1'b0;
        cfg_rwn_i           = 1'b0;

        cfg_rx_en_i         = 1'b1;
        cfg_rx_pending_i    = 1'b1;
        cfg_rx_curr_addr_i  = 12'b000000000000;
        cfg_rx_bytes_left_i = 1'h5;

        cfg_tx_en_i         = 1'b0;
        cfg_tx_pending_i    = 1'b0;
        cfg_tx_curr_addr_i  = 12'b0000000000000;
        cfg_tx_bytes_left_i = 1'h0;

        data_tx_gnt_i       = 1'b0;
        data_tx_i           = 2'h00;
        data_tx_valid_i     = 1'b0;
        data_rx_ready_i     = 1'b0;

        #10;
        rstn_i              = 1'b0;
        send_data();
        do_configs();
    end
    // this section focusing on data sending part
    task send_data();
        #100;
        data_tx_valid_i = 1'b1;
        data_tx_gnt_i   = 1'b1;
        #1;
        data_tx_i       = 2'h55;
    endtask:send_data
    // Configuration changes
    
    task do_configs();
        cfg_tx_en_i         = 1'b1;
    endtask: do_configs
endmodule:manual_data_send