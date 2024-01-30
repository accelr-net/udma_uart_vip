`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

module tb_top_spi;
    localparam  HALF_CLOCK_PERIOD   = 10;
    localparam  L2_AWIDTH_NOAL      = 12;
    localparam  TRANS_SIZE          = 16;
    localparam  REPLAY_BUFFER_DEPTH = 6;

    logic                       sys_clk_i;
    logic                       periph_clk_i;
    logic                       rstn_i;

    logic                       dft_test_mode_i;     
    logic                       dft_cg_enable_i;     

    logic                       spi_eot_o;           

    logic                [3:0]  spi_event_i;         

    logic                [31:0] cfg_data_i;          
    logic                 [4:0] cfg_addr_i;          
    logic                       cfg_valid_i;         
    logic                       cfg_rwn_i;           
    logic                [31:0] cfg_data_o;          
    logic                       cfg_ready_o;         

    logic  [L2_AWIDTH_NOAL-1:0] cfg_cmd_startaddr_o; 
    logic      [TRANS_SIZE-1:0] cfg_cmd_size_o;      
    logic                       cfg_cmd_continuous_o;
    logic                       cfg_cmd_en_o;        
    logic                       cfg_cmd_clr_o;       
    logic                       cfg_cmd_en_i;        
    logic                       cfg_cmd_pending_i;   
    logic  [L2_AWIDTH_NOAL-1:0] cfg_cmd_curr_addr_i; 
    logic      [TRANS_SIZE-1:0] cfg_cmd_bytes_left_i;

    logic  [L2_AWIDTH_NOAL-1:0] cfg_rx_startaddr_o;  
    logic      [TRANS_SIZE-1:0] cfg_rx_size_o;       
    logic                       cfg_rx_continuous_o; 
    logic                       cfg_rx_en_o;         
    logic                       cfg_rx_clr_o;        
    logic                       cfg_rx_en_i;         
    logic                       cfg_rx_pending_i;    
    logic  [L2_AWIDTH_NOAL-1:0] cfg_rx_curr_addr_i;  
    logic      [TRANS_SIZE-1:0] cfg_rx_bytes_left_i; 

    logic  [L2_AWIDTH_NOAL-1:0] cfg_tx_startaddr_o;  
    logic      [TRANS_SIZE-1:0] cfg_tx_size_o;       
    logic                       cfg_tx_continuous_o;
    logic                       cfg_tx_en_o;         
    logic                       cfg_tx_clr_o;        
    logic                       cfg_tx_en_i;         
    logic                       cfg_tx_pending_i;    
    logic  [L2_AWIDTH_NOAL-1:0] cfg_tx_curr_addr_i;  
    logic      [TRANS_SIZE-1:0] cfg_tx_bytes_left_i; 

    logic                       cmd_req_o;           
    logic                       cmd_gnt_i;           
    logic                 [1:0] cmd_datasize_o;      
    logic                [31:0] cmd_i;               
    logic                       cmd_valid_i;         
    logic                       cmd_ready_o;         

    logic                       data_tx_req_o;       
    logic                       data_tx_gnt_i;       
    logic                 [1:0] data_tx_datasize_o;  
    logic                [31:0] data_tx_i;           
    logic                       data_tx_valid_i;     
    logic                       data_tx_ready_o;     

    logic                 [1:0] data_rx_datasize_o;  
    logic                [31:0] data_rx_o;           
    logic                       data_rx_valid_o;     
    logic                       data_rx_ready_i;     

    logic                       spi_clk_o;           
    logic                       spi_csn0_o;          
    logic                       spi_csn1_o;          
    logic                       spi_csn2_o;          
    logic                       spi_csn3_o;          
    logic                       spi_oen0_o;          
    logic                       spi_oen1_o;          
    logic                       spi_oen2_o;          
    logic                       spi_oen3_o;          
    logic                       spi_sdo0_o;          
    logic                       spi_sdo1_o;          
    logic                       spi_sdo2_o;          
    logic                       spi_sdo3_o;          
    logic                       spi_sdi0_i;          
    logic                       spi_sdi1_i;          
    logic                       spi_sdi2_i;          
    logic                       spi_sdi3_i;          
    
    spi_slave_bfm #(
        .clk_polarity(0),
        .clk_phase(0)
    ) spi_slave (
        .sclk(spi_clk_o),
        .mosi(spi_sdo1_o),
        .miso(spi_sdi1_i),
        .ss(spi_csn1_o)
    );


    udma_spim_top #(
        .L2_AWIDTH_NOAL(12),
        .TRANS_SIZE(16),
        .REPLAY_BUFFER_DEPTH(6)
    ) spi_top (
        .sys_clk_i              (sys_clk_i           ),
        .periph_clk_i           (periph_clk_i        ),
        .rstn_i                 (rstn_i              ),

        .dft_test_mode_i        (dft_test_mode_i     ),
        .dft_cg_enable_i        (dft_cg_enable_i     ),

        .spi_eot_o              (spi_eot_o           ),

        .spi_event_i            (spi_event_i         ),

        .cfg_data_i             (cfg_data_i          ),
        .cfg_addr_i             (cfg_addr_i          ),
        .cfg_valid_i            (cfg_valid_i         ),
        .cfg_rwn_i              (cfg_rwn_i           ),
        .cfg_data_o             (cfg_data_o          ),
        .cfg_ready_o            (cfg_ready_o         ),

        .cfg_cmd_startaddr_o    (cfg_cmd_startaddr_o ),
        .cfg_cmd_size_o         (cfg_cmd_size_o      ),
        .cfg_cmd_continuous_o   (cfg_cmd_continuous_o),
        .cfg_cmd_en_o           (cfg_cmd_en_o        ),
        .cfg_cmd_clr_o          (cfg_cmd_clr_o       ),
        .cfg_cmd_en_i           (cfg_cmd_en_i        ),
        .cfg_cmd_pending_i      (cfg_cmd_pending_i   ),
        .cfg_cmd_curr_addr_i    (cfg_cmd_curr_addr_i ),
        .cfg_cmd_bytes_left_i   (cfg_cmd_bytes_left_i),

        .cfg_rx_startaddr_o     (cfg_rx_startaddr_o  ),
        .cfg_rx_size_o          (cfg_rx_size_o       ),
        .cfg_rx_continuous_o    (cfg_rx_continuous_o ),
        .cfg_rx_en_o            (cfg_rx_en_o         ),
        .cfg_rx_clr_o           (cfg_rx_clr_o        ),
        .cfg_rx_en_i            (cfg_rx_en_i         ),
        .cfg_rx_pending_i       (cfg_rx_pending_i    ),
        .cfg_rx_curr_addr_i     (cfg_rx_curr_addr_i  ),
        .cfg_rx_bytes_left_i    (cfg_rx_bytes_left_i ),

        .cfg_tx_startaddr_o     (cfg_tx_startaddr_o  ),
        .cfg_tx_size_o          (cfg_tx_size_o       ),
        .cfg_tx_continuous_o    (cfg_tx_continuous_o ),
        .cfg_tx_en_o            (cfg_tx_en_o         ),
        .cfg_tx_clr_o           (cfg_tx_clr_o        ),
        .cfg_tx_en_i            (cfg_tx_en_i         ),
        .cfg_tx_pending_i       (cfg_tx_pending_i    ),
        .cfg_tx_curr_addr_i     (cfg_tx_curr_addr_i  ),
        .cfg_tx_bytes_left_i    (cfg_tx_bytes_left_i ),

        .cmd_req_o              (cmd_req_o           ),
        .cmd_gnt_i              (cmd_gnt_i           ),
        .cmd_datasize_o         (cmd_datasize_o      ),
        .cmd_i                  (cmd_i               ),
        .cmd_valid_i            (cmd_valid_i         ),
        .cmd_ready_o            (cmd_ready_o         ),
    
        .data_tx_req_o          (data_tx_req_o       ),
        .data_tx_gnt_i          (data_tx_gnt_i       ),
        .data_tx_datasize_o     (data_tx_datasize_o  ),
        .data_tx_i              (data_tx_i           ),
        .data_tx_valid_i        (data_tx_valid_i     ),
        .data_tx_ready_o        (data_tx_ready_o     ),
    
        .data_rx_datasize_o     (data_rx_datasize_o  ),
        .data_rx_o              (data_rx_o           ),
        .data_rx_valid_o        (data_rx_valid_o     ),
        .data_rx_ready_i        (data_rx_ready_i     ),

        .spi_clk_o              (spi_clk_o           ),
        .spi_csn0_o             (spi_csn0_o          ),
        .spi_csn1_o             (spi_csn1_o          ),
        .spi_csn2_o             (spi_csn2_o          ),
        .spi_csn3_o             (spi_csn3_o          ),
        .spi_oen0_o             (spi_oen0_o          ),
        .spi_oen1_o             (spi_oen1_o          ),
        .spi_oen2_o             (spi_oen2_o          ),
        .spi_oen3_o             (spi_oen3_o          ),
        .spi_sdo0_o             (spi_sdo0_o          ),
        .spi_sdo1_o             (spi_sdo1_o          ),
        .spi_sdo2_o             (spi_sdo2_o          ),
        .spi_sdo3_o             (spi_sdo3_o          ),
        .spi_sdi0_i             (spi_sdi0_i          ),
        .spi_sdi1_i             (spi_sdi1_i          ),
        .spi_sdi2_i             (spi_sdi2_i          ),
        .spi_sdi3_i             (spi_sdi3_i          )
    );

    initial begin
        sys_clk_i               = 1'b1;
        forever begin 
            #HALF_CLOCK_PERIOD sys_clk_i           = ~sys_clk_i;
        end
    end

    initial begin
        periph_clk_i               = 1'b1;
        forever begin 
            #HALF_CLOCK_PERIOD periph_clk_i        = ~periph_clk_i;
        end
    end

    initial begin : RESET_BLOCK
        rstn_i              = 1'b0;
        #(HALF_CLOCK_PERIOD);
        rstn_i      = 1'b1;
    end

    initial begin
        #(20);
        cfg_data_i  = 32'b0;
        cfg_addr_i  = 5'b0;  
        cfg_valid_i = 1'b0;
        cfg_rwn_i   = 1'b1;

        #(HALF_CLOCK_PERIOD);
        cfg_valid_i = 1'b1;
        cfg_rwn_i   = 1'b0;
        //cmd_cfg
        #(HALF_CLOCK_PERIOD);
        cfg_data_i  = {25'h0,'b0,1'b0,1'b1,1'b0,2'b10,1'b1};
        cfg_addr_i  = 5'b01001;  

        //rx_cfg
        #(HALF_CLOCK_PERIOD);
        cfg_data_i  = {25'h0,1'b0,1'b0,1'b1,1'b0,2'b10,1'b1};
        cfg_addr_i  = 5'b00110;  
        
        #(HALF_CLOCK_PERIOD);
        cmd_gnt_i   = 1'b1;
        cmd_valid_i = 1'b1;

        // sending_data_cmds();
        

        // #100;
        // spi_slave.tx_miso_byte(.data("8'd2"));

        // #(HALF_CLOCK_PERIOD);
        // cmd_gnt_i   = 1'b1;
        // cmd_valid_i = 1'b1;

        // #(HALF_CLOCK_PERIOD*2);
        // cmd_i       = {4'h9,26'h0,1'b0,1'b0};       // SPI_CMD_EOT

        #100
        receiving_data_cmds();
    end

    initial begin
        data_rx_ready_i     = 1'b1;
    end

    initial begin
        data_tx_valid_i     = 1'b0;
        data_tx_gnt_i       = 1'b0;
        forever begin
            @(posedge data_tx_ready_o);
            data_tx_valid_i  = 1'b1;
            data_tx_gnt_i    = 1'b1;
            #(HALF_CLOCK_PERIOD*2);
            data_tx_i        = 32'b11011011011011011011011011011011;
        end
    end
    
    task receiving_data_cmds;
        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h0,18'h0,1'b1,1'b1,8'd100};        //  SPI_CMD_CFG

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h1,26'h0,2'b01};                   // SPI_CMD_SOT

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h2,1'b0,1'b0,6'h0,4'h8,16'h50};    // SPI_CMD_SEND_CMD

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h7,1'b0,1'b0,6'h0,4'h8,16'h50};    // SPI_CMD_RX_DATA

        #(HALF_CLOCK_PERIOD);
        cmd_gnt_i   = 1'b0;
        cmd_valid_i = 1'b0;
    endtask: receiving_data_cmds

    task sending_data_cmds;
        //starting 
        #(HALF_CLOCK_PERIOD*2);
        cmd_gnt_i   = 1'b1;
        cmd_valid_i = 1'b1;

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h0,18'h0,1'b1,1'b1,8'd100}; //  SPI_CMD_CFG

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h1,26'h0,2'b01}; // SPI_CMD_SOT

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h2,1'b0,1'b0,6'h0,4'h8,16'h50}; // SPI_CMD_SEND_CMD

        #(HALF_CLOCK_PERIOD*2);
        cmd_i       = {4'h6,1'b0,1'b0,6'h0,4'h8,16'h50};
        // cmd_i       = {4'h6,28'h0};  // SPI_CMD_TX_DATA


        #(HALF_CLOCK_PERIOD);
        cmd_gnt_i   = 1'b0;
        cmd_valid_i = 1'b0;
        //ending
    endtask: sending_data_cmds
endmodule: tb_top_spi