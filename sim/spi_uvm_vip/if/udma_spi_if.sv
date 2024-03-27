// ************************************************************************************************
//
// PROJECT      :   SPI Verification Env
// PRODUCT      :   N/A
// FILE         :   spi_if.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is a interface for spi module and outside of the SoC. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  23-Jan-2024      Kasun        creation
//
//**************************************************************************************************

//**************************************************************************************************
//                                      PIN DIAGRAM , modports & clocking blocks 
//**************************************************************************************************
//                                                 +-----------------+
//                                                 |                 |<----sys_clk_i
//                                                 |                 |<----periph_clk_i
//                                                 |                 |<----rstn_i
//                                                 |                 |
//                                                 |                 |---->rx_char_event_o 
//                                                 |                 |---->err_event_o
//                                                 |                 |
//                                                 |                 |<----cfg_data_i            <--------+
//                                                 |                 |<----cfg_addr_i                     |
//                                                 |                 |<----cfg_valid_i                    |
//                                                 |                 |<----cfg_rwn_i                      |
//                                                 |                 |---->cfg_ready_o                    |
//                                                 |                 |---->cfg_data_o                     |  
//                                                 |                 |---->cfg_rx_startaddr_o             |
//                                                 |                 |---->cfg_rx_size_o                  |
//                                                 |                 |---->cfg_rx_datasize_o              |
//                                                 |                 |---->cfg_rx_continuous_o            |
//                   +---->          spi_clk_o<----|                 |---->cfg_rx_en_o                    |
//                   |               spi_csn0_o<---|                 |---->cfg_rx_clr_o                   |
//                   |               spi_csn1_o<---|                 |<----cfg_rx_en_i                    | cfg_driver_if
//                   |               spi_csn2_o<---|                 |<----cfg_rx_pending_i               |
//                   |               spi_csn3_o<---|                 |<----cfg_rx_curr_addr_i             |
//                   |               spi_oen0_o<---|                 |<----cfg_rx_bytes_left_i            |
//                   |               spi_oen1_o<---|  udma_spim_top  |---->cfg_tx_startaddr_o             |
//                   |               spi_oen2_o<---|                 |---->cfg_tx_size_o                  |
//          spi_if   |               spi_oen3_o<---|                 |---->cfg_tx_datasize_o              |
//                   |               spi_sdo0_o<---|                 |---->cfg_tx_continuous_o            |
//                   |               spi_sdo1_o<---|                 |---->cfg_tx_en_o                    |
//                   |               spi_sdo2_o<---|                 |---->cfg_tx_clr_o                   |
//                   |               spi_sdo3_o<---|                 |<----cfg_tx_en_i                    |
//                   |               spi_sdi0_i--->|                 |<----cfg_tx_pending_i               |
//                   |               spi_sdi1_i--->|                 |<----cfg_tx_curr_addr_i             |
//                   |               spi_sdi2_i--->|                 |<----cfg_tx_byte_left_i    <--------+
//                   +---->          spi_sdi3_i--->|                 |
//                                                 |                 |---->data_tx_req_o         <--------+
//                                                 |                 |<----data_tx_gnt_i                  |
//                                                 |                 |---->data_tx_datasize_o             | 
//                                                 |                 |<----data_tx_i                      | udma_tx_driver_if
//                                                 |                 |<----data_tx_valid_i                |
//                                                 |                 |---->data_tx_ready_o       <--------+
//                                                 |                 |
//                                                 |                 |---->data_rx_datasize_o    <--------+
//                                                 |                 |---->data_rx_o                      | udma_rx_driver_if
//                                                 |                 |---->data_rx_valid_o                |
//                                                 |                 |<----data_rx_ready_i       <--------+
//                                                 +-----------------+
// 
//*****************************************************************************************************************

interface udma_spi_if #(
    parameter L2_AWIDTH_NOAL = 12,
    parameter TRANS_SIZE     = 16,
    parameter REPLAY_BUFFER_DEPTH = 6
)(
    input  logic                      sys_clk_i,
    input  logic                      periph_clk_i,
    input  logic                      rstn_i
);

    logic                      dft_test_mode_i;
    logic                      dft_cg_enable_i;
    
    logic                      spi_eot_o;
    
    logic                [3:0] spi_event_i;
    
    logic               [31:0] cfg_data_i;
    logic                [4:0] cfg_addr_i;
    logic                      cfg_valid_i;
    logic                      cfg_rwn_i;
    logic               [31:0] cfg_data_o;
    logic                      cfg_ready_o;

    logic [L2_AWIDTH_NOAL-1:0] cfg_cmd_startaddr_o;
    logic     [TRANS_SIZE-1:0] cfg_cmd_size_o;
    logic                      cfg_cmd_continuous_o;
    logic                      cfg_cmd_en_o;
    logic                      cfg_cmd_clr_o;
    logic                      cfg_cmd_en_i;
    logic                      cfg_cmd_pending_i;
    logic [L2_AWIDTH_NOAL-1:0] cfg_cmd_curr_addr_i;
    logic     [TRANS_SIZE-1:0] cfg_cmd_bytes_left_i;
    
    logic [L2_AWIDTH_NOAL-1:0] cfg_rx_startaddr_o;
    logic     [TRANS_SIZE-1:0] cfg_rx_size_o;
    logic                      cfg_rx_continuous_o;
    logic                      cfg_rx_en_o;
    logic                      cfg_rx_clr_o;
    logic                      cfg_rx_en_i;
    logic                      cfg_rx_pending_i;
    logic [L2_AWIDTH_NOAL-1:0] cfg_rx_curr_addr_i;
    logic     [TRANS_SIZE-1:0] cfg_rx_bytes_left_i;
    
    logic [L2_AWIDTH_NOAL-1:0] cfg_tx_startaddr_o;
    logic     [TRANS_SIZE-1:0] cfg_tx_size_o;
    logic                      cfg_tx_continuous_o;
    logic                      cfg_tx_en_o;
    logic                      cfg_tx_clr_o;
    logic                      cfg_tx_en_i;
    logic                      cfg_tx_pending_i;
    logic [L2_AWIDTH_NOAL-1:0] cfg_tx_curr_addr_i;
    logic     [TRANS_SIZE-1:0] cfg_tx_bytes_left_i;
    
    logic                      cmd_req_o;
    logic                      cmd_gnt_i;
    logic                [1:0] cmd_datasize_o;
    logic               [31:0] cmd_i;
    logic                      cmd_valid_i;
    logic                      cmd_ready_o;
    
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

    //Clocking blocks for driver
    clocking tx_data_cbd @(posedge sys_clk_i);
        input                  data_tx_req_o;
        output                 data_tx_gnt_i;
        input                  data_tx_datasize_o;
        output                 data_tx_i;
        output                 data_tx_valid_i;
        input                  data_tx_ready_o;    
    endclocking

    //Clocking blocks for monitor
    clocking tx_data_cbm @(posedge sys_clk_i);
        input                   data_tx_req_o;
        input                   data_tx_gnt_i;
        input                   data_tx_datasize_o;
        input                   data_tx_i;
        input                   data_tx_valid_i;
        input                   data_tx_ready_o;
    endclocking   

    clocking rx_data_cbm @(posedge sys_clk_i);
        input                   data_rx_datasize_o;
        input                   data_rx_o;
        input                   data_rx_valid_o;
        input                   data_rx_ready_i;
    endclocking

    clocking rx_data_cbd @(posedge sys_clk_i);
        input                   data_rx_datasize_o;
        input                   data_rx_o;
        input                   data_rx_valid_o;
        output                  data_rx_ready_i;
    endclocking
endinterface : udma_spi_if