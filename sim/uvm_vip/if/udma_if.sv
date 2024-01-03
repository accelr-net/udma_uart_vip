// ************************************************************************************************
//
// Copyright 2023, Acceler Logic (Pvt) Ltd, Sri Lanka
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
//                                                 |                 |<----cfg_valid_i                    |  udma_cfg
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
)(
    input                        sys_clk_i,
    input                        rstn_i,
    input                        periph_clk_i
);
    //udma_uart_top
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

    clocking event_cbd @(posedge sys_clk_i);
        input                   rx_char_event_o;
        input                   err_event_o;
    endclocking

    clocking cfg_cbd @(posedge sys_clk_i);
        output                  periph_clk_i;
        input                  rstn_i;

        output                  cfg_data_i;
        output                  cfg_addr_i;
        output                  cfg_valid_i;
        output                  cfg_rwn_i;

        input                   cfg_ready_o;
        input                   cfg_data_o;
    endclocking

    clocking rx_cfg_cbd @(posedge sys_clk_i);
        input                   cfg_rx_startaddr_o;
        input                   cfg_rx_size_o;
        input                   cfg_rx_datasize_o;
        input                   cfg_rx_continuous_o;
        input                   cfg_rx_en_o;
        input                   cfg_rx_clr_o;

        output                  cfg_rx_en_i;
        output                  cfg_rx_pending_i;
        output                  cfg_rx_curr_addr_i;
        output                  cfg_rx_bytes_left_i;
    endclocking

    clocking rx_data_cbd @(posedge sys_clk_i);
        input                   data_rx_datasize_o;
        input                   data_rx_o;
        input                   data_rx_valid_o;
        output                  data_rx_ready_i;
    endclocking

    clocking tx_cfg_cbd @(posedge sys_clk_i);
        input                   cfg_tx_startaddr_o;
        input                   cfg_tx_size_o;
        input                   cfg_tx_datasize_o;
        input                   cfg_tx_continuous_o;
        input                   cfg_tx_en_o;
        input                   cfg_tx_clr_o;

        output                  cfg_tx_en_i;
        output                  cfg_tx_pending_i;
        output                  cfg_tx_curr_addr_i;
        output                  cfg_tx_bytes_left_i;
    endclocking

    clocking tx_data_cbd @(posedge sys_clk_i);
        input                   data_tx_req_o;
        output                  data_tx_gnt_i;
        input                   data_tx_datasize_o;
        output                  data_tx_i;
        output                  data_tx_valid_i;
        input                   data_tx_ready_o;
    endclocking
//-------------------------------------------------------
//Monitor clocking blocks
//-------------------------------------------------------
    clocking event_cbm @(posedge sys_clk_i);
        input                   rx_char_event_o;
        input                   err_event_o;
    endclocking

    clocking cfg_cbm @(posedge sys_clk_i);
        input                  periph_clk_i;
        input                  rstn_i;

        input                  cfg_data_i;
        input                  cfg_addr_i;
        input                  cfg_valid_i;
        input                  cfg_rwn_i;

        input                   cfg_ready_o;
        input                   cfg_data_o;
    endclocking

    clocking rx_cfg_cbm @(posedge sys_clk_i);
        input                   cfg_rx_startaddr_o;
        input                   cfg_rx_size_o;
        input                   cfg_rx_datasize_o;
        input                   cfg_rx_continuous_o;
        input                   cfg_rx_en_o;
        input                   cfg_rx_clr_o;

        input                  cfg_rx_en_i;
        input                  cfg_rx_pending_i;
        input                  cfg_rx_curr_addr_i;
        input                  cfg_rx_bytes_left_i;
    endclocking

    clocking rx_data_cbm @(posedge sys_clk_i);
        input                   data_rx_datasize_o;
        input                   data_rx_o;
        input                   data_rx_valid_o;
        input                   data_rx_ready_i;
    endclocking

    clocking tx_cfg_cbm @(posedge sys_clk_i);
        input                   cfg_tx_startaddr_o;
        input                   cfg_tx_size_o;
        input                   cfg_tx_datasize_o;
        input                   cfg_tx_continuous_o;
        input                   cfg_tx_en_o;
        input                   cfg_tx_clr_o;

        input                  cfg_tx_en_i;
        input                  cfg_tx_pending_i;
        input                  cfg_tx_curr_addr_i;
        input                  cfg_tx_bytes_left_i;
    endclocking

    clocking tx_data_cbm @(posedge sys_clk_i);
        input                   data_tx_req_o;
        input                   data_tx_gnt_i;
        input                   data_tx_datasize_o;
        input                   data_tx_i;
        input                   data_tx_valid_i;
        input                   data_tx_ready_o;
    endclocking
endinterface: udma_if