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
    int char_length         = 8;
    bit parity_en           = 1'b0;
    bit error_inject_enabled = 1'b0;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_sequence");
        super.new(name);
        `uvm_info("[SEQUENCE]","constructor", UVM_HIGH)
        if(!uvm_config_db #(int)::get(null,"*","char_length",char_length)) begin
            `uvm_fatal("[SEQUENCE]","cannot find char_length");
        end
        if(!uvm_config_db #(bit)::get(null,"*","parity_en",parity_en)) begin
            `uvm_fatal("[SEQUENCE]","Cannot find parity_en");
        end
        if(!uvm_config_db #(bit)::get(null,"*","parity_error",error_inject_enabled)) begin
            `uvm_fatal("uart_driver/build_phase","Please set error_inject_enabled config");
        end
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        uart_seq_item          uart_rx_transaction;
        bit                    parity;
        repeat(10) begin
            uart_rx_transaction = uart_seq_item::type_id::create("uart_rx_transaction");
            start_item(uart_rx_transaction);
            uart_rx_transaction.set_character_length(char_length);
            uart_rx_transaction.set_data(8'h3,parity_en,1'b1);
            uart_rx_transaction.randomize();
            if(error_inject_enabled) begin
                parity = $urandom_range(1,0);
                uart_rx_transaction.set_parity(parity);
            end
            finish_item(uart_rx_transaction);
        end
    endtask: body
endclass: uart_sequence