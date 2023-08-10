/////////////////////////////////////////////////////////////////////////////////////
//
// This is for only learn about uart protocal of pulp
//
//////////////////////////////////////////////////////////////////////////////////////////
module manual_data_send();
    localparam L2_AWIDTH_NOAL = 19;
    localparam TRANS_SIZE     = 20;
    localparam SIZE_18        =  18'b000000000000000000;
    localparam SIZE_19        =  19'b0000000000000000000; 
    
    //for uart_sim
    localparam BAUD_RATE      = 115200;
    localparam PARITY_EN      = 0;

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

    //uart_sim variables
    logic                      uart_sim_tx_o;
    udma_uart_top #(
        .L2_AWIDTH_NOAL (L2_AWIDTH_NOAL),
        .TRANS_SIZE     (TRANS_SIZE)
    ) uart (
        .*
    );

    uart_sim #(
        .BAUD_RATE(BAUD_RATE),
        .PARITY_EN(PARITY_EN)
    ) uart_sim(
        .rx     (uart_tx_o),
        .tx     (uart_rx_i),
        .rx_en  (data_rx_valid_o)
    );

    udma_sim from_udma_sim(
        .sys_clk_i          (sys_clk_i),
        .data_tx_req_i      (data_tx_req_o),
        .data_tx_ready_i    (data_tx_ready_o),
        
        .data_tx_gnt_o      (data_tx_gnt_i),
        .data_tx_o          (data_tx_i),
        .data_tx_valid_o    (data_tx_valid_i)
    );

    always begin
        #10 periph_clk_i <= ~periph_clk_i; 
    end
    always begin
        #10 sys_clk_i    <= ~sys_clk_i;
    end
    initial begin
        $display("Manual_data_send starting...");
        rstn_i              <= 1'b0;
        // uart_rx_i           <= 1'b1;
        // uart_tx_o           <= 1'b0;

        cfg_data_i          <= 32'h000000000;
        cfg_addr_i          <= 4'b0000;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_rx_en_i         <= 1'b0;
        cfg_rx_pending_i    <= 1'b0;
        cfg_rx_curr_addr_i  <= SIZE_18;
        cfg_rx_bytes_left_i <= SIZE_19;

        cfg_tx_en_i         <= 1'b0;
        cfg_tx_pending_i    <= 1'b0;
        cfg_tx_curr_addr_i  <= SIZE_18;
        cfg_tx_bytes_left_i <= SIZE_19;

        // data_tx_gnt_i       <= 1'b0;
        // data_tx_i           <= 32'h00000000;
        // data_tx_valid_i     <= 1'b0;
        data_rx_ready_i     <= 1'b0;
        send_data();
        do_configs();
        rx_data_send();
        from_udma_sim.send_char(32'h55);
        $display("manual_data_send is done!!!");
        $display("New version 2");
    end
    // send manual data to uart tx pin
    task send_data();
        #5 rstn_i           <= 1'b1; 

    endtask: send_data

    task do_configs();
        #20;
        cfg_data_i          <= 32'h00000000;
        cfg_rwn_i           <= 1'b0;
        #10;
        cfg_data_i          <= 32'h00000000;
        cfg_rwn_i           <= 1'b1;
        #100;
        cfg_rwn_i           <= 1'b0;
        cfg_addr_i          <= 5'b01001;
        cfg_data_i          <= 32'h01B20306;
        #10;
        cfg_valid_i         <= 1'b1;
        #10;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_data_i          <= 32'h00000000;
        cfg_addr_i          <= 5'b00000;

        #10;
        cfg_rwn_i           <= 1'b0;
        cfg_addr_i          <= 5'b00100;
        cfg_data_i          <= 32'h1c000934;
        #10;
        cfg_valid_i         <= 1'b1;
        #10;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_data_i          <= 32'h00000000;
        cfg_addr_i          <= 5'b00000;
        
        #10;
        cfg_rwn_i           <= 1'b0;
        cfg_addr_i          <= 5'b00101;
        cfg_data_i          <= 32'h00000080;
        #10;
        cfg_valid_i         <= 1'b1;
        #10;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_data_i          <= 32'h00000000;
        cfg_addr_i          <= 5'b00000;
               
        #10;
        cfg_rwn_i           <= 1'b0;
        cfg_addr_i          <= 5'b00110;
        cfg_data_i          <= 32'h00000010;
        #10;
        cfg_valid_i         <= 1'b1;
        #10;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_data_i          <= 32'h00000000;
        cfg_addr_i          <= 5'b00000;
        #10;
        cfg_rx_en_i         <= 1'b1;
        #10;
    endtask: do_configs

    task rx_data_send();
        #10;
        cfg_rwn_i           <= 1'b0;
        cfg_rx_bytes_left_i <= 20'h00050;
        cfg_rx_curr_addr_i  <= 19'h00934;
        #10;
        cfg_valid_i         <= 1'b1;
        #10;
        cfg_valid_i         <= 1'b0;
        cfg_rwn_i           <= 1'b1;
        cfg_data_i          <= 32'h00000000;
        cfg_addr_i          <= 5'b00000;
        data_rx_ready_i     <= 1'b1;
        for (int i = 0; i < 10; i++) begin
            @(posedge sys_clk_i);
            uart_sim.send_char(8'b00010101);
            @(posedge sys_clk_i);
            uart_sim.send_char(8'b01010110);
        end
        @(posedge sys_clk_i);
        cfg_rx_en_i         <= 1'b0;
    endtask : rx_data_send

endmodule:manual_data_send