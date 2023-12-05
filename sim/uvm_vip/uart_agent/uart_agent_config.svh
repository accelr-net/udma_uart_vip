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
// FILE         :   uart_agent_config.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for configuration for uart_agent. 
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
class uart_agent_config extends uvm_object;
    `uvm_object_utils(uart_agent_config)
    int                             baud_rate   = 115200;
    int                             frequency   = 50000000;
    int                             stop_bits   = 1;
    bit                             parity_en   = 1'b1;
    int                             char_length = 8;
    int                             clock_period= 10;
    bit                             is_rx_agent = 1'b1;

    function new(string name="uart_agent_config");
        super.new(name);
        `uvm_info("[uart_agent_config]","constructor",UVM_LOW)
    endfunction: new
endclass : uart_agent_config