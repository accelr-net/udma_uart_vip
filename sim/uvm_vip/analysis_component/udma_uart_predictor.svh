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
// FILE         :   udma_uart_predictor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is take uart_seq_item from analysis export then make udma_seq_item and 
//                  put on another analysis port 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  6-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class udma_uart_predictor extends uvm_subscriber #(udma_tx_seq_item);
    `uvm_component_utils(udma_uart_predictor)

    uvm_analysis_port   #(uart_seq_item)     expected_uart_aport;

    function new(string name="udma_uart_predictor",uvm_component parent);
        super.new(name,parent);
        expected_uart_aport = new("expected_uart_aport",this);
    endfunction: new

    virtual function void write(udma_tx_seq_item t);
        uart_seq_item                            expected_uart_item;
        logic     [7:0]                            character;
        expected_uart_item      = uart_seq_item::type_id::create("expected_uart_txn",this);
        //make expected_udma_txn here
        t.get_uart_char(character);
        expected_uart_item.set_char(character);

        $display("%s character: %p %s",PURPLE,character,WHITE);
        //write expected_udma_txn into analysis port
        expected_uart_aport.write(expected_uart_item);
    endfunction: write
endclass: udma_uart_predictor