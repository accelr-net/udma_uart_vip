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
// FILE         :   uart_rx_sequence.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence object for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_sequence extends uvm_sequence;
    `uvm_object_utils(uart_rx_sequence)
    uart_rx_seq_item #(.CHARACTOR_LENGTH(8))           uart_rx_transaction;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_sequence");
        super.new(name);
        `uvm_info("[SEQUENCE]","constructor", UVM_LOW)
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        repeat(5) begin
            uart_rx_transaction = uart_rx_seq_item #(.CHARACTOR_LENGTH(8))::type_id::create("uart_rx_transaction");
            // uart_rx_transaction.randomize();
            start_item(uart_rx_transaction);
            // uart_rx_transaction.charactor <= 8'd10;
            finish_item(uart_rx_transaction);
        end
    endtask: body
endclass: uart_rx_sequence