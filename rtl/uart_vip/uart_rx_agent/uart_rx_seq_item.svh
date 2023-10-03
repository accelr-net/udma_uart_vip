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
// FILE         :   uart_rx_seq_item.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence item for uart RX. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Seq-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_seq_item extends uvm_sequence_item;
    `uvm_object_utils(uart_rx_seq_item)
    typedef enum {PARITY_ENABLE,PARITY_DISABLE}     parity_type;
    parity_type                                     parity_en;
    int                                             charactor_length;                                
    rand bit                                        charactor[];
    rand logic                                      parity;

    // constraint c_charactor {charactor.size() > 5; charactor.size < 9;}ma
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_seq_item");
        super.new(name);
        `uvm_info("[SEQ_ITEM]","constructor",UVM_LOW)
    endfunction: new

    //set data values
    function set_data(
        bit             charactor[]
    );
        this.charactor   = charactor;
        calculate_parity(charactor);
    endfunction: set_data

    //calculate parity
    function calculate_parity(bit charactor[]);
        this.parity = 1'b1;
        for(int i = 0; i < $size(charactor); i++) begin
            this.parity = this.parity^charactor[i];
        end
    endfunction: calculate_parity

    function void pre_randomize();
        charactor = new [charactor_length];
    endfunction

    function void post_randomize();
        calculate_parity(charactor);
    endfunction
endclass : uart_rx_seq_item