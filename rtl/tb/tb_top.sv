/////////////////////////////////////////////////////////////////////////////////////
//
// This is for only learn about uart protocal of pulp
//
//////////////////////////////////////////////////////////////////////////////////////////
import uvm_pkg::*;
`include "uvm_macros.svh"

// cfg_agent_pkg is a UVM agent
import cfg_agent_pkg::*;

module tb_top();
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

    udma_if #(
        .L2_WIDTH_NOAL(L2_AWIDTH_NOAL),
        .TRANS_SIZE(TRANS_SIZE),
        .DATA_SIZE(32)
    ) vif();

    uart_if  intf_uart_side();

    udma_uart_top #(
        .L2_AWIDTH_NOAL (L2_AWIDTH_NOAL),
        .TRANS_SIZE     (TRANS_SIZE)
    ) uart (
        .sys_clk_i              (vif.udma_top_if.sys_clk_i               ),
        .periph_clk_i           (vif.udma_top_if.periph_clk_i            ),
        .rstn_i                 (vif.udma_top_if.rstn_i                  ),

        .uart_rx_i              (intf_uart_side.uart_dut_if.uart_rx_i               ),
        .uart_tx_o              (intf_uart_side.uart_dut_if.uart_tx_o               ),

        .rx_char_event_o        (vif.udma_top_if.rx_char_event_o         ),
        .err_event_o            (vif.udma_top_if.err_event_o             ),

        .cfg_data_i             (vif.udma_top_if.cfg_data_i              ),
        .cfg_addr_i             (vif.udma_top_if.cfg_addr_i              ),
        .cfg_valid_i            (vif.udma_top_if.cfg_valid_i             ),
        .cfg_rwn_i              (vif.udma_top_if.cfg_rwn_i               ),
        .cfg_ready_o            (vif.udma_top_if.cfg_ready_o             ),
        .cfg_data_o             (vif.udma_top_if.cfg_data_o              ),

        .cfg_rx_startaddr_o     (vif.udma_top_if.cfg_rx_startaddr_o      ),
        .cfg_rx_size_o          (vif.udma_top_if.cfg_rx_size_o           ),
        .cfg_rx_datasize_o      (vif.udma_top_if.cfg_rx_datasize_o       ),
        .cfg_rx_continuous_o    (vif.udma_top_if.cfg_rx_continuous_o     ),
        .cfg_rx_en_o            (vif.udma_top_if.cfg_rx_en_o             ),
        .cfg_rx_clr_o           (vif.udma_top_if.cfg_rx_clr_o            ),
        .cfg_rx_en_i            (vif.udma_top_if.cfg_rx_en_i             ),
        .cfg_rx_pending_i       (vif.udma_top_if.cfg_rx_pending_i        ),
        .cfg_rx_curr_addr_i     (vif.udma_top_if.cfg_rx_curr_addr_i      ),
        .cfg_rx_bytes_left_i    (vif.udma_top_if.cfg_rx_bytes_left_i     ),
        
        .cfg_tx_startaddr_o     (vif.udma_top_if.cfg_tx_startaddr_o      ),
        .cfg_tx_size_o          (vif.udma_top_if.cfg_tx_size_o           ),
        .cfg_tx_datasize_o      (vif.udma_top_if.cfg_tx_datasize_o       ),
        .cfg_tx_continuous_o    (vif.udma_top_if.cfg_tx_continuous_o     ),
        .cfg_tx_en_o            (vif.udma_top_if.cfg_tx_en_o             ),
        .cfg_tx_clr_o           (vif.udma_top_if.cfg_tx_clr_o            ),
        .cfg_tx_en_i            (vif.udma_top_if.cfg_tx_en_i             ),
        .cfg_tx_pending_i       (vif.udma_top_if.cfg_tx_pending_i        ),
        .cfg_tx_curr_addr_i     (vif.udma_top_if.cfg_tx_curr_addr_i      ),
        .cfg_tx_bytes_left_i    (vif.udma_top_if.cfg_tx_bytes_left_i     ),
        
        .data_tx_req_o          (vif.udma_top_if.data_tx_req_o           ),
        .data_tx_gnt_i          (vif.udma_top_if.data_tx_gnt_i           ),
        .data_tx_datasize_o     (vif.udma_top_if.data_tx_datasize_o      ),
        .data_tx_i              (vif.udma_top_if.data_tx_i               ),
        .data_tx_valid_i        (vif.udma_top_if.data_tx_valid_i         ),
        .data_tx_ready_o        (vif.udma_top_if.data_tx_ready_o         ),

        .data_rx_datasize_o     (vif.udma_top_if.data_rx_datasize_o      ),
        .data_rx_o              (vif.udma_top_if.data_rx_o               ),
        .data_rx_valid_o        (vif.udma_top_if.data_rx_valid_o         ),
        .data_rx_ready_i        (vif.udma_top_if.data_rx_ready_i         )
    );

    always begin
        #10 vif.udma_top_if.periph_clk_i <= ~vif.udma_top_if.periph_clk_i; 
    end
    always begin
        #10 vif.udma_top_if.sys_clk_i    <= ~vif.udma_top_if.sys_clk_i;
    end      

    initial begin
        vif.udma_top_if.sys_clk_i <= 1'b1;
        vif.udma_top_if.periph_clk_i <= 1'b1;
        $display("[manual_data_send] - before run test v.3");
        run_test("cfg_test");      
    end

    initial begin
        uvm_config_db #(virtual udma_if)::set(null,"*","vif",vif);
    end
endmodule: tb_top