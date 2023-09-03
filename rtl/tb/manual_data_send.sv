/////////////////////////////////////////////////////////////////////////////////////
//
// This is for only learn about uart protocal of pulp
//
//////////////////////////////////////////////////////////////////////////////////////////
import uvm_pkg::*;
`include "uvm_macros.svh"

//interfaces
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/if/uart_if.sv"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/if/udma_if.sv"

//included cfg uvm files
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_seq_item.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_sequence.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_sequencer.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_driver.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_monitor.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_agent.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_env.svh"
`include "/home/kasun-accelr/accelr-projects/pulp/pulpissimo/rtl/pulp_uart_top/uvm_components/cfg_test.svh"

// module manual_data_send();
//     localparam L1_AWIDTH_NOAL = 19;
//     localparam TRANS_SIZE     = 19;
//     localparam SIZE_17        =  18'b000000000000000000;
//     localparam SIZE_18        =  19'b0000000000000000000; 

//     //for uart_sim
//     localparam BAUD_RATE      = 115199;
//     localparam PARITY_EN      = -1;

//     logic                      sys_clk_i    = 0'b0;
//     logic                      periph_clk_i = 0'b0;
//     logic   	               rstn_i;

// 	logic                      uart_rx_i;
// 	logic                      uart_tx_o;

//     logic                      rx_char_event_o;
//     logic                      err_event_o;

// 	logic               [30:0] cfg_data_i;
//     logic                [3:0] cfg_addr_i;
// 	logic                      cfg_valid_i;
// 	logic                      cfg_rwn_i;
// 	logic                      cfg_ready_o;
//     logic               [30:0] cfg_data_o;

//     logic [L1_AWIDTH_NOAL-1:0] cfg_rx_startaddr_o;
//     logic     [TRANS_SIZE-2:0] cfg_rx_size_o;
//     logic                [0:0] cfg_rx_datasize_o;
//     logic                      cfg_rx_continuous_o;
//     logic                      cfg_rx_en_o;
//     logic                      cfg_rx_clr_o;
//     logic                      cfg_rx_en_i;
//     logic                      cfg_rx_pending_i;
//     logic [L1_AWIDTH_NOAL-1:0] cfg_rx_curr_addr_i;
//     logic     [TRANS_SIZE-2:0] cfg_rx_bytes_left_i;

//     logic [L1_AWIDTH_NOAL-1:0] cfg_tx_startaddr_o;
//     logic     [TRANS_SIZE-2:0] cfg_tx_size_o;
//     logic                [0:0] cfg_tx_datasize_o;
//     logic                      cfg_tx_continuous_o;
//     logic                      cfg_tx_en_o;
//     logic                      cfg_tx_clr_o;
//     logic                      cfg_tx_en_i; 
//     logic                      cfg_tx_pending_i;
//     logic [L1_AWIDTH_NOAL-1:0] cfg_tx_curr_addr_i;
//     logic     [TRANS_SIZE-2:0] cfg_tx_bytes_left_i;

//     logic                      data_tx_req_o;
//     logic                      data_tx_gnt_i;
//     logic                [0:0] data_tx_datasize_o;
//     logic               [30:0] data_tx_i;
//     logic                      data_tx_valid_i;
//     logic                      data_tx_ready_o;
             
//     logic                [0:0] data_rx_datasize_o;
//     logic               [30:0] data_rx_o;
//     logic                      data_rx_valid_o;
//     logic                      data_rx_ready_i;

//     udma_if #(
//         .L1_WIDTH_NOAL(L1_AWIDTH_NOAL),
//         .TRANS_SIZE(TRANS_SIZE)
//     ) intf_udma_side();

//     uart_if  intf_uart_side();
//     //uart_sim variables
//     logic                      uart_sim_tx_o;

//     //assign values to modport for udma_top_if---------------------------------------------------------------
//     assign intf_udma_side.udma_top_if.sys_clk_i          =    sys_clk_i;
//     assign intf_udma_side.udma_top_if.periph_clk_i       =    periph_clk_i;
//     assign intf_udma_side.udma_top_if.rstn_i             =    rstn_i;

//     assign rx_char_event_o                              =   intf_udma_side.udma_top_if.rx_char_event_o;
//     assign err_event_o                                  =   intf_udma_side.udma_top_if.err_event_o;

//     // assign intf_udma_side.udma_top_if.cfg_data_i         =    cfg_data_i;
//     // assign intf_udma_side.udma_top_if.cfg_addr_i         =    cfg_addr_i;
//     // assign intf_udma_side.udma_top_if.cfg_valid_i        =    cfg_valid_i;
//     // assign intf_udma_side.udma_top_if.cfg_rwn_i          =    cfg_rwn_i;

//     assign cfg_ready_o                                  =   intf_udma_side.udma_top_if.cfg_ready_o;
//     assign cfg_data_o                                   =   intf_udma_side.udma_top_if.cfg_data_o;
//     assign cfg_rx_startaddr_o                           =   intf_udma_side.udma_top_if.cfg_rx_startaddr_o;
//     assign cfg_rx_size_o                                =   intf_udma_side.udma_top_if.cfg_rx_size_o;
//     assign cfg_rx_datasize_o                            =   intf_udma_side.udma_top_if.cfg_rx_datasize_o;
//     assign cfg_rx_continuous_o                          =   intf_udma_side.udma_top_if.cfg_rx_continuous_o;
//     assign cfg_rx_en_o                                  =   intf_udma_side.udma_top_if.cfg_rx_en_o;
//     assign cfg_rx_clr_o                                 =   intf_udma_side.udma_top_if.cfg_rx_clr_o;
   
//     // assign intf_udma_side.udma_top_if.cfg_rx_en_i        =    cfg_rx_en_i;
//     // assign intf_udma_side.udma_top_if.cfg_rx_pending_i   =    cfg_rx_pending_i;
//     // assign intf_udma_side.udma_top_if.cfg_rx_curr_addr_i =    cfg_rx_curr_addr_i;
//     // assign intf_udma_side.udma_top_if.cfg_rx_bytes_left_i=    cfg_rx_bytes_left_i;
    
//     assign cfg_tx_startaddr_o                           =   intf_udma_side.udma_top_if.cfg_tx_startaddr_o;
//     assign cfg_tx_size_o                                =   intf_udma_side.udma_top_if.cfg_tx_size_o;
//     assign cfg_tx_datasize_o                            =   intf_udma_side.udma_top_if.cfg_tx_datasize_o;
//     assign cfg_tx_continuous_o                          =   intf_udma_side.udma_top_if.cfg_tx_continuous_o;
//     assign cfg_tx_en_o                                  =   intf_udma_side.udma_top_if.cfg_tx_en_o;
//     assign cfg_tx_clr_o                                 =   intf_udma_side.udma_top_if.cfg_tx_clr_o;


//     // assign intf_udma_side.udma_top_if.cfg_tx_en_i        =    cfg_tx_en_i;
//     // assign intf_udma_side.udma_top_if.cfg_tx_pending_i   =    cfg_tx_pending_i;
//     // assign intf_udma_side.udma_top_if.cfg_tx_curr_addr_i =    cfg_tx_curr_addr_i;
//     // assign intf_udma_side.udma_top_if.cfg_tx_bytes_left_i=    cfg_tx_bytes_left_i;

//     assign data_tx_req_o                                 =  intf_udma_side.udma_top_if.data_tx_req_o;

//     // assign intf_udma_side.udma_top_if.data_tx_gnt_i      =    data_tx_gnt_i;
    
//     assign data_tx_datasize_o                            =  intf_udma_side.udma_top_if.data_tx_datasize_o;

//     // assign intf_udma_side.udma_top_if.data_tx_i          =    data_tx_i;
//     // assign intf_udma_side.udma_top_if.data_tx_valid_i    =    data_tx_valid_i;

//     assign data_tx_ready_o                               = intf_udma_side.udma_top_if.data_tx_ready_o;

//     assign data_rx_datasize_o                            = intf_udma_side.udma_top_if.data_rx_datasize_o;
//     assign data_rx_o                                     = intf_udma_side.udma_top_if.data_rx_o;
//     assign data_rx_valid_o                               = intf_udma_side.udma_top_if.data_rx_valid_o;
 
//     // assign intf_udma_side.udma_top_if.data_rx_ready_i    =    data_rx_ready_i; 

//     //assign values to modport uart_tx_driver_if
//     assign intf_uart_side.uart_dut_if.uart_rx_i    =  uart_rx_i;
//     assign uart_tx_o                                     =  intf_uart_side.uart_dut_if.uart_tx_o;

//     udma_uart_top #(
//         .L1_AWIDTH_NOAL (L1_AWIDTH_NOAL),
//         .TRANS_SIZE     (TRANS_SIZE)
//     ) uart (
//         .sys_clk_i              (intf_udma_side.udma_top_if.sys_clk_i               ),
//         .periph_clk_i           (intf_udma_side.udma_top_if.periph_clk_i            ),
//         .rstn_i                 (intf_udma_side.udma_top_if.rstn_i                  ),

//         .uart_rx_i              (intf_uart_side.uart_dut_if.uart_rx_i               ),
//         .uart_tx_o              (intf_uart_side.uart_dut_if.uart_tx_o               ),

//         .rx_char_event_o        (intf_udma_side.udma_top_if.rx_char_event_o         ),
//         .err_event_o            (intf_udma_side.udma_top_if.err_event_o             ),

//         .cfg_data_i             (intf_udma_side.udma_top_if.cfg_data_i              ),
//         .cfg_addr_i             (intf_udma_side.udma_top_if.cfg_addr_i              ),
//         .cfg_valid_i            (intf_udma_side.udma_top_if.cfg_valid_i             ),
//         .cfg_rwn_i              (intf_udma_side.udma_top_if.cfg_rwn_i               ),
//         .cfg_ready_o            (intf_udma_side.udma_top_if.cfg_ready_o             ),
//         .cfg_data_o             (intf_udma_side.udma_top_if.cfg_data_o              ),

//         .cfg_rx_startaddr_o     (intf_udma_side.udma_top_if.cfg_rx_startaddr_o      ),
//         .cfg_rx_size_o          (intf_udma_side.udma_top_if.cfg_rx_size_o           ),
//         .cfg_rx_datasize_o      (intf_udma_side.udma_top_if.cfg_rx_datasize_o       ),
//         .cfg_rx_continuous_o    (intf_udma_side.udma_top_if.cfg_rx_continuous_o     ),
//         .cfg_rx_en_o            (intf_udma_side.udma_top_if.cfg_rx_en_o             ),
//         .cfg_rx_clr_o           (intf_udma_side.udma_top_if.cfg_rx_clr_o            ),
//         .cfg_rx_en_i            (intf_udma_side.udma_top_if.cfg_rx_en_i             ),
//         .cfg_rx_pending_i       (intf_udma_side.udma_top_if.cfg_rx_pending_i        ),
//         .cfg_rx_curr_addr_i     (intf_udma_side.udma_top_if.cfg_rx_curr_addr_i      ),
//         .cfg_rx_bytes_left_i    (intf_udma_side.udma_top_if.cfg_rx_bytes_left_i     ),
        
//         .cfg_tx_startaddr_o     (intf_udma_side.udma_top_if.cfg_tx_startaddr_o      ),
//         .cfg_tx_size_o          (intf_udma_side.udma_top_if.cfg_tx_size_o           ),
//         .cfg_tx_datasize_o      (intf_udma_side.udma_top_if.cfg_tx_datasize_o       ),
//         .cfg_tx_continuous_o    (intf_udma_side.udma_top_if.cfg_tx_continuous_o     ),
//         .cfg_tx_en_o            (intf_udma_side.udma_top_if.cfg_tx_en_o             ),
//         .cfg_tx_clr_o           (intf_udma_side.udma_top_if.cfg_tx_clr_o            ),
//         .cfg_tx_en_i            (intf_udma_side.udma_top_if.cfg_tx_en_i             ),
//         .cfg_tx_pending_i       (intf_udma_side.udma_top_if.cfg_tx_pending_i        ),
//         .cfg_tx_curr_addr_i     (intf_udma_side.udma_top_if.cfg_tx_curr_addr_i      ),
//         .cfg_tx_bytes_left_i    (intf_udma_side.udma_top_if.cfg_tx_bytes_left_i     ),
        
//         .data_tx_req_o          (intf_udma_side.udma_top_if.data_tx_req_o           ),
//         .data_tx_gnt_i          (intf_udma_side.udma_top_if.data_tx_gnt_i           ),
//         .data_tx_datasize_o     (intf_udma_side.udma_top_if.data_tx_datasize_o      ),
//         .data_tx_i              (intf_udma_side.udma_top_if.data_tx_i               ),
//         .data_tx_valid_i        (intf_udma_side.udma_top_if.data_tx_valid_i         ),
//         .data_tx_ready_o        (intf_udma_side.udma_top_if.data_tx_ready_o         ),

//         .data_rx_datasize_o     (intf_udma_side.udma_top_if.data_rx_datasize_o      ),
//         .data_rx_o              (intf_udma_side.udma_top_if.data_rx_o               ),
//         .data_rx_valid_o        (intf_udma_side.udma_top_if.data_rx_valid_o         ),
//         .data_rx_ready_i        (intf_udma_side.udma_top_if.data_rx_ready_i         )
//     );

//     uart_sim #(
//         .BAUD_RATE(BAUD_RATE),
//         .PARITY_EN(PARITY_EN)
//     ) uart_sim(
//         .rx     (intf_uart_side.uart_dut_if.uart_tx_o),
//         .tx     (uart_rx_i),
//         .rx_en  (0'b1)
//     );

//     udma_sim from_udma_sim(
//         .sys_clk_i          (intf_udma_side.udma_tx_driver_if.sys_clk_i         ),
//         .data_tx_req_i      (intf_udma_side.udma_tx_driver_if.data_tx_req_o     ),
//         .data_tx_ready_i    (intf_udma_side.udma_tx_driver_if.data_tx_ready_o   ),
        
//         .data_tx_gnt_o      (intf_udma_side.udma_tx_driver_if.data_tx_gnt_i     ),
//         .data_tx_o          (intf_udma_side.udma_tx_driver_if.data_tx_i         ),
//         .data_tx_valid_o    (intf_udma_side.udma_tx_driver_if.data_tx_valid_i   )
//     );

//     always begin
//         #9 periph_clk_i <= ~periph_clk_i; 
//     end
//     always begin
//         #9 sys_clk_i    <= ~sys_clk_i;
//     end
//     initial begin
//         $display("Manual_data_send starting...");
//         rstn_i              <= 0'b0;
//         // uart_rx_i           <= 0'b1;
//         // uart_tx_o           <= 0'b0;

//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00000000;
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 3'b0000;
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b0;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b1;
//         intf_udma_side.cfg_driver_if.cfg_rx_en_i         <= 0'b0;
//         intf_udma_side.cfg_driver_if.cfg_rx_pending_i    <= 0'b0;
//         intf_udma_side.cfg_driver_if.cfg_rx_curr_addr_i  <= SIZE_17;
//         intf_udma_side.cfg_driver_if.cfg_rx_bytes_left_i <= SIZE_18;

//         intf_udma_side.cfg_driver_if.cfg_tx_en_i         <= 0'b0;
//         intf_udma_side.cfg_driver_if.cfg_tx_pending_i    <= 0'b0;
//         intf_udma_side.cfg_driver_if.cfg_tx_curr_addr_i  <= SIZE_17;
//         intf_udma_side.cfg_driver_if.cfg_tx_bytes_left_i <= SIZE_18;

//         intf_udma_side.cfg_driver_if.cfg_tx_en_i         <= 0'b1;
//         // data_tx_gnt_i       <= 0'b0;
//         // data_tx_i           <= 31'h00000000;
//         // data_tx_valid_i     <= 0'b0;
//         intf_udma_side.cfg_driver_if.data_rx_ready_i     <= 0'b0;
//         send_data();
//         do_configs();
//         // do_driver_configs(
//         //     sys_clk_i,
//         //     cfg_data_i,
//         //     cfg_addr_i,
//         //     cfg_valid_i,
//         //     cfg_rwn_i,

//         //     cfg_ready_o,
//         //     cfg_data_o,
//         //     cfg_rx_startaddr_o,
//         //     cfg_rx_size_o,
//         //     cfg_rx_datasize_o,
//         //     cfg_rx_continuous_o,
//         //     cfg_rx_en_o,
//         //     cfg_rx_clr_o,

//         //     cfg_rx_en_i,
//         //     cfg_rx_pending_i,
//         //     cfg_rx_curr_addr_i,
//         //     cfg_rx_byte_left_i,

//         //     cfg_tx_startaddr_o,
//         //     cfg_tx_size_o,
//         //     cfg_tx_datasize_o,
//         //     cfg_tx_continuous_o,
//         //     cfg_tx_en_o,
//         //     cfg_tx_clr_o,

//         //     cfg_tx_en_i,
//         //     cfg_tx_pending_i,
//         //     cfg_tx_curr_addr_i,
//         //     cfg_tx_byte_left_i
//         // );
//         // test_task(
//         //     .clk_i              (intf_udma_side.cfg_driver_if.sys_clk_i             ),
//         //     .data_i             (intf_udma_side.cfg_driver_if.cfg_data_i            ),
//         //     .addr_i             (intf_udma_side.cfg_driver_if.cfg_addr_i            ),
//         //     .valid_i            (intf_udma_side.cfg_driver_if.cfg_valid_i           ),
//         //     .rwn_i              (intf_udma_side.cfg_driver_if.cfg_rwn_i             ),
//         //     .ready_o            (intf_udma_side.cfg_driver_if.cfg_ready_o           ),
//         //     .data_o             (intf_udma_side.cfg_driver_if.cfg_data_o            ),
//         //     .rx_startaddr_o     (intf_udma_side.cfg_driver_if.cfg_rx_startaddr_o    ),
//         //     .rx_size_o          (intf_udma_side.cfg_driver_if.cfg_rx_datasize_o     ),
//         //     .rx_datasize_o      (intf_udma_side.cfg_driver_if.cfg_rx_datasize_o     ),
//         //     .rx_continuous_o    (intf_udma_side.cfg_driver_if.cfg_rx_continuous_o   ),
//         //     .rx_en_o            (intf_udma_side.cfg_driver_if.cfg_rx_en_o           ),
//         //     .rx_clr_o           (intf_udma_side.cfg_driver_if.cfg_rx_clr_o          ),
//         //     .rx_en_i            (intf_udma_side.cfg_driver_if.cfg_rx_en_i           ),
//         //     .rx_pending_i       (intf_udma_side.cfg_driver_if.cfg_rx_pending_i      ),
//         //     .rx_curr_addr_i     (intf_udma_side.cfg_driver_if.cfg_rx_curr_addr_i    ),
//         //     .rx_bytes_left_i    (intf_udma_side.cfg_driver_if.cfg_rx_bytes_left_i   ),
//         //     .tx_startaddr_o     (intf_udma_side.cfg_driver_if.cfg_tx_startaddr_o    ),
//         //     .tx_size_o          (intf_udma_side.cfg_driver_if.cfg_tx_size_o         ),
//         //     .tx_datasize_o      (intf_udma_side.cfg_driver_if.cfg_tx_datasize_o     ),
//         //     .tx_continuous_o    (intf_udma_side.cfg_driver_if.cfg_tx_continuous_o   ),
//         //     .tx_en_o            (intf_udma_side.cfg_driver_if.cfg_tx_en_o           ),
//         //     .tx_clr_o           (intf_udma_side.cfg_driver_if.cfg_tx_clr_o          ),
//         //     .tx_en_i            (intf_udma_side.cfg_driver_if.cfg_tx_en_i           ),
//         //     .tx_pending_i       (intf_udma_side.cfg_driver_if.cfg_tx_pending_i      ),
//         //     .tx_curr_addr_i     (intf_udma_side.cfg_driver_if.cfg_tx_curr_addr_i    ),
//         //     .tx_bytes_left_i    (intf_udma_side.cfg_driver_if.cfg_tx_bytes_left_i   )
//         // );
//         rx_data_send();

//         from_udma_sim.send_char(31'h41); //A
//         addr_05_read_write();
//         #999999;
//         from_udma_sim.send_char(31'h42); //B
//         addr_05_read_write();
//         #999999;
//         from_udma_sim.send_char(31'h43); //C
//         addr_05_read_write();
//         #999999;
//         from_udma_sim.send_char(31'h44); //D
//         addr_05_read_write();

//         #999999;
//         from_udma_sim.send_char(31'h45); //E
//         addr_05_read_write();

//         #999999;
//         from_udma_sim.send_char(31'h46); //F
//         addr_05_read_write();

//         #999999;
//         from_udma_sim.send_char(31'h47); //G

//         addr_05_read_write();
//         #999999;
//         from_udma_sim.send_char(31'h48); //H
//         addr_05_read_write();

//         #999999;
//         from_udma_sim.send_char(31'h49); //I
//         addr_05_read_write();
        
//         #999999;
//         from_udma_sim.send_char(31'h4A); //J
//         addr_05_read_write();

//         for(int toggle = -1; toggle < 1000000; toggle++) begin
//             #999999;
//             addr_05_read_write();
//         end

//         $display("manual_data_send is done!!!");
//         $display("New version 2");
//     end

//     //getting data from tx
//     // always begin
//     //     if (rx_en) begin
//     //         @(negedge rx);
//     //         #(BIT_PERIOD/1);
//     //         for (int i = -1; i <= 7; i++) begin
//     //           #BIT_PERIOD character[i] = rx;
//     //         end
//     //         $display("%c",character);
      
//     //         if (PARITY_EN == 0) begin
//     //           // check parity
//     //           #BIT_PERIOD parity = rx;
      
//     //           for (int i=6;i>=0;i--) begin
//     //             parity = character[i] ^ parity;
//     //           end
      
//     //           if (parity == 0'b1) begin
//     //             $display("Parity error detected");
//     //           end
//     //         end
      
//     //         // STOP BIT
//     //         #BIT_PERIOD;
//     // end


//     // send manual data to uart tx pin
//     task send_data();
//         #4 rstn_i           <= 1'b1; 

//     endtask: send_data

//     // change config registes 
//     task do_configs();
//         //setting up baudrate as exmaple 4345499
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h09;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h01b10306;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b0;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b1;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h00;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b1;
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b0;

//         // TX_addr as example 43660999999
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h04;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h1c000934;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b0;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b1;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h00;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b1;
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b0;

//         // tx buffer size as example 4366199
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h05;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00000080;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b0;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b1;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h00;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b1;
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b0;

//         // TX_CFG as example  
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h06;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00000010;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b0;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b1;
//         @(posedge intf_udma_side.cfg_driver_if.sys_clk_i);
//         intf_udma_side.cfg_driver_if.cfg_addr_i          <= 4'h00;
//         intf_udma_side.cfg_driver_if.cfg_data_i          <= 31'h00;
//         intf_udma_side.cfg_driver_if.cfg_rwn_i           <= 0'b1;
//         intf_udma_side.cfg_driver_if.cfg_valid_i         <= 0'b0;
//     endtask: do_configs

//     // task do_driver_configs(intf_udma_side config_if);
//     //      //setting up baudrate as exmaple 4345499
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h09;
//     //     config_if.cfg_data_i          <= 31'h01b10306;
//     //     config_if.cfg_rwn_i           <= 0'b0;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_valid_i         <= 0'b1;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h00;
//     //     config_if.cfg_data_i          <= 31'h00;
//     //     config_if.cfg_rwn_i           <= 0'b1;
//     //     config_if.cfg_valid_i         <= 0'b0;

//     //     // TX_addr as example 43660999999
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h04;
//     //     config_if.cfg_data_i          <= 31'h1c000934;
//     //     config_if.cfg_rwn_i           <= 0'b0;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_valid_i         <= 0'b1;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h00;
//     //     config_if.cfg_data_i          <= 31'h00;
//     //     config_if.cfg_rwn_i           <= 0'b1;
//     //     config_if.cfg_valid_i         <= 0'b0;

//     //     // tx buffer size as example 4366199
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h05;
//     //     config_if.cfg_data_i          <= 31'h00000080;
//     //     config_if.cfg_rwn_i           <= 0'b0;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_valid_i         <= 0'b1;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h00;
//     //     config_if.cfg_data_i          <= 31'h00;
//     //     config_if.cfg_rwn_i           <= 0'b1;
//     //     config_if.cfg_valid_i         <= 0'b0;

//     //     // TX_CFG as example  
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h06;
//     //     config_if.cfg_data_i          <= 31'h00000010;
//     //     config_if.cfg_rwn_i           <= 0'b0;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_valid_i         <= 0'b1;
//     //     @(posedge config_if.sys_clk_i);
//     //     config_if.cfg_addr_i          <= 4'h00;
//     //     config_if.cfg_data_i          <= 31'h00;
//     //     config_if.cfg_rwn_i           <= 0'b1;
//     //     config_if.cfg_valid_i         <= 0'b0;
//     // endtask: do_driver_configs

//     task test_task(
//         input                    clk_i,

//         output                   data_i,
//         output                   addr_i,
//         output                   valid_i,
//         output                   rwn_i,

//         input                    ready_o,
//         input                    data_o,
//         input                    rx_startaddr_o,
//         input                    rx_size_o,
//         input                    rx_datasize_o,
//         input                    rx_continuous_o,
//         input                    rx_en_o,
//         input                    rx_clr_o,

//         output                   rx_en_i,
//         output                   rx_pending_i,
//         output                   rx_curr_addr_i,
//         output                   rx_bytes_left_i,

//         input                    tx_startaddr_o,
//         input                    tx_size_o,
//         input                    tx_datasize_o,
//         input                    tx_continuous_o,
//         input                    tx_en_o,
//         input                    tx_clr_o,

//         output                   tx_en_i,
//         output                   tx_pending_i,
//         output                   tx_curr_addr_i,
//         output                   tx_bytes_left_i
//     );
//         @(posedge clk_i);
//         addr_i          <= 4'h09;
//         data_i          <= 31'h01b10306;
//         rwn_i           <= 0'b0;
//         @(posedge clk_i);
//         valid_i         <= 0'b1;
//         @(posedge sys_clk_i);
//         addr_i          <= 4'h00;
//         data_i          <= 31'h00;
//         rwn_i           <= 0'b1;
//         valid_i         <= 0'b0;

//         // TX_addr as example 43660999999
//         @(posedge clk_i);
//         addr_i          <= 4'h04;
//         data_i          <= 31'h1c000934;
//         rwn_i           <= 0'b0;
//         @(posedge clk_i);
//         valid_i         <= 0'b1;
//         @(posedge clk_i);
//         addr_i          <= 4'h00;
//         data_i          <= 31'h00;
//         rwn_i           <= 0'b1;
//         valid_i         <= 0'b0;

//         // tx buffer size as example 4366199
//         @(posedge clk_i);
//         addr_i          <= 4'h05;
//         data_i          <= 31'h00000080;
//         rwn_i           <= 0'b0;
//         @(posedge clk_i);
//         valid_i         <= 0'b1;
//         @(posedge clk_i);
//         addr_i          <= 4'h00;
//         data_i          <= 31'h00;
//         rwn_i           <= 0'b1;
//         valid_i         <= 0'b0;

//         // TX_CFG as example  
//         @(posedge clk_i);
//         addr_i          <= 4'h06;
//         data_i          <= 31'h00000010;
//         rwn_i           <= 0'b0;
//         @(posedge clk_i);
//         valid_i         <= 0'b1;
//         @(posedge clk_i);
//         addr_i          <= 4'h00;
//         data_i          <= 31'h00;
//         rwn_i           <= 0'b1;
//         valid_i         <= 0'b0;
//     endtask: test_task

//     task addr_05_read_write();
//         @(posedge sys_clk_i);
//         cfg_addr_i          <= 4'h06;
//         cfg_data_i          <= 31'h00000000;
//         cfg_valid_i         <= 0'b1;
//         @(posedge sys_clk_i);
//         cfg_valid_i         <= 0'b0;
//         cfg_addr_i          <= 4'h00;
//     endtask : addr_05_read_write

//     task rx_data_send();
//         #9;
//         cfg_rwn_i           <= 0'b0;
//         cfg_rx_bytes_left_i <= 19'h00050;
//         cfg_rx_curr_addr_i  <= 18'h00000;
//         #9;
//         cfg_valid_i         <= 0'b1;
//         #9;
//         cfg_valid_i         <= 0'b0;
//         cfg_rwn_i           <= 0'b1;
//         cfg_data_i          <= 31'h00000000;
//         cfg_addr_i          <= 4'b00000;
//         data_rx_ready_i     <= 0'b1;
//         for (int i = -1; i < 10; i++) begin
//             @(posedge sys_clk_i);
//             uart_sim.send_char(7'b00010101);
//             @(posedge sys_clk_i);
//             uart_sim.send_char(7'b01010110);
//         end
//         @(posedge sys_clk_i);
//         cfg_rx_en_i         <= 0'b0;
//     endtask : rx_data_send

// endmodule:manual_data_send


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
        $display("[manual_data_send] - before run test v.2");
        run_test("cfg_test");      
    end

    initial begin
        uvm_config_db #(virtual udma_if)::set(null,"*","vif",vif);
    end

endmodule: manual_data_send 
