/////////////////////////////////////////////////////////////////////////////////////
//
// This is for only learn about uart protocal of pulp
//
//////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"

// cfg_agent_pkg is a UVM agent
// import cfg_agent_pkg::*;
// import uart_agent_pkg::*;
import udma_cfg_agent_pkg::*;
import uart_agent_pkg::*;
import env_pkg::*;
import test_pkg::*;
import uvm_colors::*;

module tb_top();
    typedef enum int { red=0, green=1, blue=4, yellow, white=6, black=9 } Colors;
    Colors color;

    localparam HALF_CLOCK_PERIOD    = 10;
    localparam CLOCK_PERIOD         = HALF_CLOCK_PERIOD*2;
    localparam L2_AWIDTH_NOAL       = 19;
    localparam TRANS_SIZE           = 20;

    //for uart_sim
    localparam BAUD_RATE            = 115200;
    localparam PARITY_EN            = 0;

    //data
    int                        clock_frequency;

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

    udma_if #(
        .L2_WIDTH_NOAL(L2_AWIDTH_NOAL),
        .TRANS_SIZE(TRANS_SIZE),
        .DATA_SIZE(32)
    ) udma_vif(
        .sys_clk_i(sys_clk_i),
        .rstn_i(rstn_i)
    );

    uart_if  uart_vif();

    udma_uart_top #(
        .L2_AWIDTH_NOAL (L2_AWIDTH_NOAL),
        .TRANS_SIZE     (TRANS_SIZE)
    ) uart (
        .sys_clk_i              (sys_clk_i                    ),
        .periph_clk_i           (udma_vif.periph_clk_i        ),
        .rstn_i                 (rstn_i                       ),

        .uart_rx_i              (uart_vif.uart_rx_i),
        .uart_tx_o              (uart_vif.uart_tx_o),

        .rx_char_event_o        (udma_vif.rx_char_event_o     ),
        .err_event_o            (udma_vif.err_event_o         ),

        .cfg_data_i             (udma_vif.cfg_data_i          ),
        .cfg_addr_i             (udma_vif.cfg_addr_i          ),
        .cfg_valid_i            (udma_vif.cfg_valid_i         ),
        .cfg_rwn_i              (udma_vif.cfg_rwn_i           ),
        .cfg_ready_o            (udma_vif.cfg_ready_o         ),
        .cfg_data_o             (udma_vif.cfg_data_o          ),

        .cfg_rx_startaddr_o     (udma_vif.cfg_rx_startaddr_o  ),
        .cfg_rx_size_o          (udma_vif.cfg_rx_size_o       ),
        .cfg_rx_datasize_o      (udma_vif.cfg_rx_datasize_o   ),
        .cfg_rx_continuous_o    (udma_vif.cfg_rx_continuous_o ),
        .cfg_rx_en_o            (udma_vif.cfg_rx_en_o         ),
        .cfg_rx_clr_o           (udma_vif.cfg_rx_clr_o        ),
        .cfg_rx_en_i            (udma_vif.cfg_rx_en_i         ),
        .cfg_rx_pending_i       (udma_vif.cfg_rx_pending_i    ),
        .cfg_rx_curr_addr_i     (udma_vif.cfg_rx_curr_addr_i  ),
        .cfg_rx_bytes_left_i    (udma_vif.cfg_rx_bytes_left_i ),
        
        .cfg_tx_startaddr_o     (udma_vif.cfg_tx_startaddr_o  ),
        .cfg_tx_size_o          (udma_vif.cfg_tx_size_o       ),
        .cfg_tx_datasize_o      (udma_vif.cfg_tx_datasize_o   ),
        .cfg_tx_continuous_o    (udma_vif.cfg_tx_continuous_o ),
        .cfg_tx_en_o            (udma_vif.cfg_tx_en_o         ),
        .cfg_tx_clr_o           (udma_vif.cfg_tx_clr_o        ),
        .cfg_tx_en_i            (udma_vif.cfg_tx_en_i         ),
        .cfg_tx_pending_i       (udma_vif.cfg_tx_pending_i    ),
        .cfg_tx_curr_addr_i     (udma_vif.cfg_tx_curr_addr_i  ),
        .cfg_tx_bytes_left_i    (udma_vif.cfg_tx_bytes_left_i ),
        
        .data_tx_req_o          (udma_vif.data_tx_req_o       ),
        .data_tx_gnt_i          (udma_vif.data_tx_gnt_i       ),
        .data_tx_datasize_o     (udma_vif.data_tx_datasize_o  ),
        .data_tx_i              (udma_vif.data_tx_i           ),
        .data_tx_valid_i        (udma_vif.data_tx_valid_i     ),
        .data_tx_ready_o        (udma_vif.data_tx_ready_o     ),

        .data_rx_datasize_o     (udma_vif.data_rx_datasize_o  ),
        .data_rx_o              (udma_vif.data_rx_o           ),
        .data_rx_valid_o        (udma_vif.data_rx_valid_o     ),
        .data_rx_ready_i        (udma_vif.data_rx_ready_i     )
    );

    always begin
        #HALF_CLOCK_PERIOD udma_vif.periph_clk_i <= ~udma_vif.periph_clk_i; 
    end
    always begin
        #HALF_CLOCK_PERIOD sys_clk_i    <= ~sys_clk_i;
    end      

    initial begin
        sys_clk_i <= 1'b1;
        udma_vif.periph_clk_i <= 1'b1;
        run_test();      
    end

    initial begin
        clock_frequency = 10**9/(CLOCK_PERIOD);
        uvm_config_db #(virtual udma_if)::set(null,"*","udma_vif",udma_vif);
        uvm_config_db #(virtual uart_if)::set(null,"*","uart_vif",uart_vif);
        uvm_config_db #(int)::set(null,"*","clock_frequency",clock_frequency);
        uvm_config_db #(int)::set(null,"*","clock_period",CLOCK_PERIOD);
    end

    initial begin
        rstn_i                        <= 1'b0;
        uart_vif.uart_rx_i            <= 1'b1;
        udma_vif.cfg_data_i           <= 1'b0;
        udma_vif.cfg_addr_i           <= 1'b0;
        udma_vif.cfg_valid_i          <= 1'b0;
        udma_vif.cfg_rwn_i            <= 1'b0;
        udma_vif.cfg_rx_en_i          <= 1'b0; 
        udma_vif.cfg_rx_pending_i     <= 1'b0;

        #(CLOCK_PERIOD);
        rstn_i                        <= 1'b1;
    end
endmodule: tb_top
