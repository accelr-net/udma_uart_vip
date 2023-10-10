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
// FILE         :   uart_rx_agent_config.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for configuration for uart_rx_agent. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_agent_config extends uvm_object;
    `uvm_object_utils(uart_rx_agent_config)
    int                             baud_rate   = 115200;
    int                             frequency   = 50000000;
    int                             stop_bits   = 1;
    uart_rx_seq_item::parity_type   parity_en   = uart_rx_seq_item::PARITY_ENABLE;
    int                             char_length = 8;
    int                             period      = 10;

    function new(string name="uart_rx_agent_config");
        super.new(name);
        `uvm_info("[uart_rx_agent_config]","constructor",UVM_LOW)
    endfunction: new
endclass : uart_rx_agent_config