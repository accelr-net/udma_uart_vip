// ************************************************************************************************
//
// Copyright 2023, Acceler Logic (Pvt) Ltd, Sri Lanka
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   UART Verification Env
// PRODUCT      :   N/A
// FILE         :   uart_seq_item.sv
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
class uart_seq_item extends uvm_sequence_item;
    `uvm_object_utils(uart_seq_item)
    bit                                                   parity_en;
    local int                                             character_length;                                
    local bit         [7:0]                               character_mask;
    local rand bit    [7:0]                               character;
    local rand bit                                        parity;
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_seq_item");
        super.new(name);
        `uvm_info("[SEQ_ITEM]","constructor",UVM_HIGH)
    endfunction: new

    //set data values
    function void set_data(
        bit     [7:0]      character,
        bit                parity_en,
        bit                parity
    );
        this.character   = character;
        this.parity_en   = parity_en;
        this.parity      = parity;
    endfunction: set_data

    //set character only
    function void set_char(
        bit     [7:0]   character
    );
        this.character = character;
    endfunction: set_char

    //set parity only manually
    function void set_parity(
        bit             parity
    );
        this.parity  = parity;
    endfunction: set_parity

    //get data value
    function void get_data(
        output bit [7:0] character_out
    );
        character_out = this.character_mask & this.character;
    endfunction: get_data

    //get parity value
    function void get_parity(
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
    function void calculate_parity();
        this.parity = 1'b0;
        for(int i = this.character_length-1; i >= 0; i--) begin
            this.parity = character[i]^this.parity;
        end
    endfunction: calculate_parity

    function void post_randomize();
        calculate_parity();
    endfunction

    function void _randomize();
        this.character = $urandom_range(256,0);
        calculate_parity();
    endfunction: _randomize

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction: do_print

    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s,"%s %s character        : %b %s\n",GREEN ,s,(this.character_mask & this.character),WHITE);
        $sformat(s,"%s %s character_length : %0d %s \n",GREEN,s, this.character_length,WHITE);
        $sformat(s,"%s parity           : %b \n" ,s, this.parity);
        $sformat(s,"%s parity_en        : %p \n" ,s, this.parity_en);
        return s;
    endfunction: convert2string

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        uart_seq_item   tr;
        bit     eq = 1'b1;
        if(!$cast(tr,rhs)) begin
            `uvm_fatal("FTR","Illegal do_compare cast")
        end
        eq &= comparer.compare_field("character",this.character,tr.character,$bits(character));
        if(parity_en == 1'b1) begin
            eq &= comparer.compare_field("parity",this.parity,tr.parity,$bits(parity));
        end
        return eq;
    endfunction: do_compare
endclass : uart_seq_item