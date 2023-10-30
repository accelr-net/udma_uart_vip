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
// FILE         :   uart_sequence.sv
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
class uart_sequence extends uvm_sequence;
    `uvm_object_utils(uart_sequence)
    int char_length = 8;
    bit parity_en   = 1;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_sequence");
        super.new(name);
        `uvm_info("[SEQUENCE]","constructor", UVM_HIGH)
        uvm_config_db #(int)::get(null,"*","char_length",char_length);
        uvm_config_db #(bit)::get(null,"*","parity_en",parity_en);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        uart_seq_item          uart_rx_transaction;
        repeat(10000) begin
            uart_rx_transaction = uart_seq_item::type_id::create("uart_rx_transaction");
            start_item(uart_rx_transaction);
            uart_rx_transaction.set_character_length(char_length);
            uart_rx_transaction.randomize();
            finish_item(uart_rx_transaction);
        end
    endtask: body
endclass: uart_sequence