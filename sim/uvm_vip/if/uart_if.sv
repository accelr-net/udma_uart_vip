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
// FILE         :   uart_peripheral_if.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is a interface between uart module and outside of the SoC. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  22-Aug-2023      Kasun        creation
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
//                                                 |                 |<----cfg_valid_i                    |
//                                                 |                 |<----cfg_rwn_i                      |
//                                                 |                 |---->cfg_ready_o                    |
//                                                 |                 |---->cfg_data_o                     |  
//                                                 |                 |---->cfg_rx_startaddr_o             |
//                                                 |                 |---->cfg_rx_size_o                  |
//                                                 |                 |---->cfg_rx_datasize_o              |
//                                                 |                 |---->cfg_rx_continuous_o            |
//                                                 |                 |---->cfg_rx_en_o                    |
//                                                 |                 |---->cfg_rx_clr_o                   |
//                                                 |                 |<----cfg_rx_en_i                    | cfg_driver_if
//                                                 |                 |<----cfg_rx_pending_i               |
//                                                 |                 |<----cfg_rx_curr_addr_i             |
//                                                 |                 |<----cfg_rx_bytes_left_i            |
//                   +---->                        |  udma_uart_top  |---->cfg_tx_startaddr_o             |
//                   |                             |                 |---->cfg_tx_size_o                  |
//  uart_driver_if   |               uart_rx_i---->|                 |---->cfg_tx_datasize_o              |
//                   |               uart_tx_o<----|                 |---->cfg_tx_continuous_o            |
//                   +---->                        |                 |---->cfg_tx_en_o                    |
//                                                 |                 |---->cfg_tx_clr_o                   |
//                                                 |                 |<----cfg_tx_en_i                    |
//                                                 |                 |<----cfg_tx_pending_i               |
//                                                 |                 |<----cfg_tx_curr_addr_i             |
//                                                 |                 |<----cfg_tx_byte_left_i    <--------+
//                                                 |                 |
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

interface uart_if;
    logic               uart_rx_i;
    logic               uart_tx_o;
    
    //connection between udma_uart_top and outside
    modport uart_dut_if(
        input           uart_rx_i,
        output          uart_tx_o
    );

    //drive tx pin into dut from outside
    modport uart_tx_if(
        input           uart_tx_o
    );

    //passive driver connect to rx from outside
    modport uart_rx_if(
        output          uart_rx_i
    );
endinterface: uart_if