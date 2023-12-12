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
    bit                                         parity_error_inject = 1'b0;

    function new(string name="uart_udma_predictor",uvm_component parent);
        super.new(name,parent);
        expected_udma_aport = new("expected_udma_aport",this);
        if(!uvm_config_db #(bit)::get(this,"","parity_error",parity_error_inject)) begin
            `uvm_fatal("uart_driver/build_phase","Please set parity_error_inject config");
        end
    endfunction: new

    virtual function void write(uart_seq_item t);
        udma_rx_seq_item                            expected_udma_item;
        bit     [7:0]                               character;
        bit                                         parity;
        bit                                         expected_parity;
        expected_udma_item      = udma_rx_seq_item::type_id::create("expected_udma_txn",this);
        //make expected_udma_txn here
        t.get_data(character);
        expected_udma_item.set_data(character);

        if(parity_error_inject) begin
            t.get_parity(parity);
            t.calculate_parity();
            t.get_parity(expected_parity);
            if(parity == expected_parity) begin
                expected_udma_aport.write(expected_udma_item);
            end
        end else begin
            //write expected_udma_txn into analysis port
            expected_udma_aport.write(expected_udma_item);
        end
    endfunction: write

endclass: uart_udma_predictor