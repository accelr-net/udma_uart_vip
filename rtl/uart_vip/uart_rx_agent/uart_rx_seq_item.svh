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
    typedef enum {PARITY_ENABLE,PARITY_DISABLE}           parity_type;
    parity_type                                           parity_en;
    local int                                             character_length;                                
    local bit         [7:0]                               character_mask;
    local rand bit    [7:0]                               character;
    local rand bit                                        parity;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_rx_seq_item");
        super.new(name);
        `uvm_info("[SEQ_ITEM]","constructor",UVM_LOW)
    endfunction: new

    //set data values
    function set_data(
        bit     [7:0]      character,
        bit                parity_en,
        bit                parity
    );
        this.character   = character;
        this.parity      = parity;
        this.parity_en   = parity_en;
    endfunction: set_data

    //get data value
    function get_data(
        output bit [7:0] character_out
    );
        character_out = this.character_mask & this.character;
    endfunction: get_data

    //get parity value
    function get_parity(
        output bit       parity_out
    );
        parity_out    = this.parity;
    endfunction: get_parity

    //set character length
    function void set_character_length(
        int     character_length
    );
        this.character_length = character_length;
        if (character_length >= 5 && character_length <= 8) begin
            this.character_mask = (1 << this.character_length) - 1;
        end else begin
            `uvm_fatal("SEQ_ITEM", "please enter valid character length between 5 and 8");
        end
    endfunction: set_character_length

    //get character length
    function int get_character_length();
        return this.character_length;
    endfunction: get_character_length

    //calculate parity
    function calculate_parity();
        this.parity = 1'b1;
        for(int i = 0; i < character_length; i++) begin
            this.parity = this.parity^character[i];
        end
    endfunction: calculate_parity

    function void post_randomize();
        calculate_parity();
    endfunction

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction: do_print

    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s,"%s Character        : %b \n" ,s,(this.character_mask & this.character));
        $sformat(s,"%s parity           : %b \n" ,s, this.parity);
        $sformat(s,"%s parity_en        : %p \n" ,s, this.parity_en);
        $sformat(s,"%s Character_length : %0d \n",s, this.character_length);
        return s;
    endfunction: convert2string
endclass : uart_rx_seq_item