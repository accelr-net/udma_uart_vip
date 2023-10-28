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
// FILE         :   uart_udma_predictor.sv
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
//  25-Oct-2023      Kasun        creation
//
//**************************************************************************************************

class uart_udma_predictor extends uvm_subscriber #(uart_seq_item);
    `uvm_component_utils(uart_udma_predictor)

    uvm_analysis_port   #(udma_rx_seq_item)     expected_udma_aport;

    function new(string name="uart_udma_predictor",uvm_component parent);
        super.new(name,parent);
        expected_udma_aport = new("expected_udma_aport",this);
    endfunction: new

    // function build_phase(uvm_phase phase);
    //     super.build_phase(phase);
    //     expected_udma_aport = new("expected_udma_aport",this);
    // endfunction: build_phase

    virtual function void write(uart_seq_item t);
        udma_rx_seq_item                            expected_udma_item;
        bit     [7:0]                               character;
        expected_udma_item      = udma_rx_seq_item::type_id::create("expected_udma_txn",this);
        //make expected_udma_txn here
        t.get_data(character);
        expected_udma_item.set_data(character);

        $display("%s expected_udma_item : %p %s",GREEN,expected_udma_item,WHITE);

        //write expected_udma_txn into analysis port
        expected_udma_aport.write(expected_udma_item);
    endfunction: write
            

endclass: uart_udma_predictor