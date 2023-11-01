// ************************************************************************************************
//
// Copyright(C) 2023 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   UART Verification Env
// PRODUCT      :   N/A
// FILE         :   udma_if.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is a interface between uart module and udma module. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  21-Aug-2023      Kasun        creation
//
//**************************************************************************************************

//**************************************************************************************************
//                                      PIN DIAGRAM & modports 
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
//                                                 |                 |<----cfg_valid_i                    |  uart_cfg
//                                                 |                 |<----cfg_rwn_i                      | 
//                                                 |                 |---->cfg_ready_o                    |
//                                                 |                 |---->cfg_data_o            <--------+  
//                                                 |                 |                           
//                                                 |                 |---->cfg_rx_startaddr_o    <--------+
//                                                 |                 |---->cfg_rx_size_o                  |
//                                                 |                 |---->cfg_rx_datasize_o              |
//                                                 |                 |---->cfg_rx_continuous_o            |
//                                                 |                 |---->cfg_rx_en_o                    |  udma_rx_cfg 
//                   +---->                        |                 |---->cfg_rx_clr_o                   |
//                   |               uart_rx_i---->|                 |<----cfg_rx_en_i                    | 
//        uart_if    |               uart_tx_o<----|  udma_uart_top  |<----cfg_rx_pending_i               |  
//                   |                             |                 |<----cfg_rx_curr_addr_i             |
//                   +---->                        |                 |<----cfg_rx_bytes_left_i   <--------+
//                                                 |                 |                                    
//                                                 |                 |---->data_rx_datasize_o    <--------+ 
//                                                 |                 |---->data_rx_o                      |  udma_rx 
//                                                 |                 |---->data_rx_valid_o                |
//                                                 |                 |<----data_rx_ready_i       <--------+
//                                                 |                 |
//                                                 |                 |---->cfg_tx_startaddr_o    <--------+
//                                                 |                 |---->cfg_tx_size_o                  |
//                                                 |                 |---->cfg_tx_datasize_o              |
//                                                 |                 |---->cfg_tx_continuous_o            |
//                                                 |                 |---->cfg_tx_en_o                    |  udma_tx_cfg
//                                                 |                 |---->cfg_tx_clr_o                   |
//                                                 |                 |<----cfg_tx_en_i                    |
//                                                 |                 |<----cfg_tx_pending_i               |  
//                                                 |                 |<----cfg_tx_curr_addr_i             |
//                                                 |                 |<----cfg_tx_byte_left_i    <--------+
//                                                 |                 |                                    
//                                                 |                 |---->data_tx_req_o         <--------+
//                                                 |                 |<----data_tx_gnt_i                  |
//                                                 |                 |---->data_tx_datasize_o             |  udma_tx
//                                                 |                 |<----data_tx_i                      | 
//                                                 |                 |<----data_tx_valid_i                |
//                                                 |                 |---->data_tx_ready_o       <--------+
//                                                 |                 |
//                                                 +-----------------+
// 
//*****************************************************************************************************************

interface udma_if #(
    parameter                    L2_WIDTH_NOAL = 19, 
    parameter                    TRANS_SIZE    = 20,

    parameter                    DATA_SIZE     = 32
);
    //udma_uart_top
    logic                        sys_clk_i;
    logic                        periph_clk_i;
    logic                        rstn_i;

    logic                        rx_char_event_o;
    logic                        err_event_o;

    logic   [DATA_SIZE-1:0]      cfg_data_i;
    logic   [4:0]                cfg_addr_i;
    logic                        cfg_valid_i;
    logic                        cfg_rwn_i;
    logic                        cfg_ready_o;
    logic   [DATA_SIZE-1:0]      cfg_data_o;
    
    logic   [L2_WIDTH_NOAL-1:0]  cfg_rx_startaddr_o;
    logic   [TRANS_SIZE-1:0]     cfg_rx_size_o;
    logic   [1:0]                cfg_rx_datasize_o;
    logic                        cfg_rx_continuous_o;
    logic                        cfg_rx_en_o;
    logic                        cfg_rx_clr_o;
    logic                        cfg_rx_en_i;
    logic                        cfg_rx_pending_i;
    logic   [L2_WIDTH_NOAL-1:0]  cfg_rx_curr_addr_i;
    logic   [TRANS_SIZE-1:0]     cfg_rx_bytes_left_i;
    
    logic   [L2_WIDTH_NOAL-1:0]  cfg_tx_startaddr_o;
    logic   [TRANS_SIZE-1:0]     cfg_tx_size_o;
    logic   [1:0]                cfg_tx_datasize_o;
    logic                        cfg_tx_continuous_o;
    logic                        cfg_tx_en_o;
    logic                        cfg_tx_clr_o;
    logic                        cfg_tx_en_i;
    logic                        cfg_tx_pending_i;
    logic   [L2_WIDTH_NOAL-1:0]  cfg_tx_curr_addr_i;
    logic   [TRANS_SIZE-1:0]     cfg_tx_bytes_left_i;

    logic                        data_tx_req_o;
    logic                        data_tx_gnt_i;
    logic   [1:0]                data_tx_datasize_o;
    logic   [DATA_SIZE-1:0]      data_tx_i;
    logic                        data_tx_valid_i;
    logic                        data_tx_ready_o;

    logic   [1:0]                data_rx_datasize_o;
    logic   [DATA_SIZE-1:0]      data_rx_o;
    logic                        data_rx_valid_o;
    logic                        data_rx_ready_i;

    // modport udma_top_if(
    //     input                   sys_clk_i,
    //     input                   periph_clk_i,
    //     input                   rstn_i,

    //     output                  rx_char_event_o,
    //     output                  err_event_o,

    //     input                   cfg_data_i,
    //     input                   cfg_addr_i,
    //     input                   cfg_valid_i,
    //     input                   cfg_rwn_i,

    //     output                  cfg_ready_o,
    //     output                  cfg_data_o,
    //     output                  cfg_rx_startaddr_o,
    //     output                  cfg_rx_size_o,
    //     output                  cfg_rx_datasize_o,
    //     output                  cfg_rx_continuous_o,
    //     output                  cfg_rx_en_o,
    //     output                  cfg_rx_clr_o,

    //     input                   cfg_rx_en_i,
    //     input                   cfg_rx_pending_i,
    //     input                   cfg_rx_curr_addr_i,
    //     input                   cfg_rx_bytes_left_i,
        
    //     output                  cfg_tx_startaddr_o,
    //     output                  cfg_tx_size_o,
    //     output                  cfg_tx_datasize_o,
    //     output                  cfg_tx_continuous_o,
    //     output                  cfg_tx_en_o,
    //     output                  cfg_tx_clr_o,

    //     input                   cfg_tx_en_i,
    //     input                   cfg_tx_pending_i,
    //     input                   cfg_tx_curr_addr_i,
    //     input                   cfg_tx_bytes_left_i,

    //     output                  data_tx_req_o,
    //     input                   data_tx_gnt_i,
    //     output                  data_tx_datasize_o,
    //     input                   data_tx_i,
    //     input                   data_tx_valid_i,
    //     output                  data_tx_ready_o,

    //     output                  data_rx_datasize_o,
    //     output                  data_rx_o,
    //     output                  data_rx_valid_o,
    //     input                   data_rx_ready_i
    // );

    // // connet to the udma_uart_top side
    // modport cfg_if(
    //     input                    sys_clk_i,

    //     input                    cfg_data_i,
    //     input                    cfg_addr_i,
    //     input                    cfg_valid_i,
    //     input                    cfg_rwn_i,

    //     output                   cfg_ready_o,
    //     output                   cfg_data_o,
    //     output                   cfg_rx_startaddr_o,
    //     output                   cfg_rx_size_o,
    //     output                   cfg_rx_datasize_o,
    //     output                   cfg_rx_continuous_o,
    //     output                   cfg_rx_en_o,
    //     output                   cfg_rx_clr_o,

    //     input                    cfg_rx_en_i,
    //     input                    cfg_rx_pending_i,
    //     input                    cfg_rx_curr_addr_i,
    //     input                    cfg_rx_bytes_left_i,

    //     output                   cfg_tx_startaddr_o,
    //     output                   cfg_tx_size_o,
    //     output                   cfg_tx_datasize_o,
    //     output                   cfg_tx_continuous_o,
    //     output                   cfg_tx_en_o,
    //     output                   cfg_tx_clr_o,

    //     input                    cfg_tx_en_i,
    //     input                    cfg_tx_pending_i,
    //     input                    cfg_tx_curr_addr_i,
    //     input                    cfg_tx_bytes_left_i
    // );

    // // connet to the config driver side
    // modport cfg_driver_if(
    //     input                    sys_clk_i,

    //     output                   cfg_data_i,
    //     output                   cfg_addr_i,
    //     output                   cfg_valid_i,
    //     output                   cfg_rwn_i,

    //     input                    cfg_ready_o,
    //     input                    cfg_data_o,
    //     input                    cfg_rx_startaddr_o,
    //     input                    cfg_rx_size_o,
    //     input                    cfg_rx_datasize_o,
    //     input                    cfg_rx_continuous_o,
    //     input                    cfg_rx_en_o,
    //     input                    cfg_rx_clr_o,

    //     output                   cfg_rx_en_i,
    //     output                   cfg_rx_pending_i,
    //     output                   cfg_rx_curr_addr_i,
    //     output                   cfg_rx_bytes_left_i,

    //     input                    cfg_tx_startaddr_o,
    //     input                    cfg_tx_size_o,
    //     input                    cfg_tx_datasize_o,
    //     input                    cfg_tx_continuous_o,
    //     input                    cfg_tx_en_o,
    //     input                    cfg_tx_clr_o,

    //     output                   cfg_tx_en_i,
    //     output                   cfg_tx_pending_i,
    //     output                   cfg_tx_curr_addr_i,
    //     output                   cfg_tx_bytes_left_i
    // );
    
    // // connet to tx port of the udma_uart_top side
    // modport udma_tx_if(
    //     input                   sys_clk_i,

    //     output                  data_tx_req_o,
    //     input                   data_tx_gnt_i,
    //     output                  data_tx_datasize_o,
    //     input                   data_tx_i,
    //     input                   data_tx_valid_i,
    //     output                  data_tx_ready_o
    // );

    // // connect to the tx port of driver side
    // modport udma_tx_driver_if(
    //     input                   sys_clk_i,

    //     input                   data_tx_req_o,
    //     output                  data_tx_gnt_i,
    //     input                   data_tx_datasize_o,
    //     output                  data_tx_i,
    //     output                  data_tx_valid_i,
    //     input                   data_tx_ready_o
    // );
    
    // // connect to the the rx port of the udma_uart_top side
    // modport udma_rx_if(
    //     input                   sys_clk_i,

    //     output                  data_rx_datasize_o,
    //     output                  data_rx_o,
    //     output                  data_rx_valid_o,
    //     input                   data_rx_ready_i
    // );

    // // connect to the rx port of the driver side
    // modport udma_rx_driver_if(
    //     input                   sys_clk_i,

    //     input                   data_rx_datasize_o,
    //     input                   data_rx_o,
    //     input                   data_rx_valid_o,
    //     output                  data_rx_ready_i
    // );

    modport event(
        output                   rx_char_event_o,
        output                   err_event_o,
    );

    modport uart_cfg(
        input                    sys_clk_i,
        input                    periph_clk_i,
        input                    rstn_i,

        input                    cfg_data_i,
        input                    cfg_addr_i,
        input                    cfg_valid_i,
        input                    cfg_rwn_i,

        output                   cfg_ready_o,
        output                   cfg_data_o,
    );

    modport udma_rx_cfg(
        input                    cfg_rx_startaddr_o,
        input                    cfg_rx_size_o,
        input                    cfg_rx_datasize_o,
        input                    cfg_rx_continuous_o,
        input                    cfg_rx_en_o,
        input                    cfg_rx_clr_o,

        output                   cfg_rx_en_i,
        output                   cfg_rx_pending_i,
        output                   cfg_rx_curr_addr_i,
        output                   cfg_rx_bytes_left_i,
    );

    modport udma_rx(
        input                   data_rx_datasize_o,
        input                   data_rx_o,
        input                   data_rx_valid_o,
        output                  data_rx_ready_i
    );

    modport udma_tx_cfg(
        input                    cfg_tx_startaddr_o,
        input                    cfg_tx_size_o,
        input                    cfg_tx_datasize_o,
        input                    cfg_tx_continuous_o,
        input                    cfg_tx_en_o,
        input                    cfg_tx_clr_o,

        output                   cfg_tx_en_i,
        output                   cfg_tx_pending_i,
        output                   cfg_tx_curr_addr_i,
        output                   cfg_tx_bytes_left_i
    );

    modport udma_tx(
        input                   sys_clk_i,

        input                   data_tx_req_o,
        output                  data_tx_gnt_i,
        input                   data_tx_datasize_o,
        output                  data_tx_i,
        output                  data_tx_valid_i,
        input                   data_tx_ready_o
    );
endinterface: udma_if