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
// FILE         :   udma_rx_req_item.svh
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
class udma_rx_seq_item extends uvm_sequence_item;
    `uvm_object_utils(udma_rx_seq_item)
    rand     int                     ready_toggle_time;
    local    logic [31:0]            data;

    constraint time_range { 
        ready_toggle_time < 100;
        ready_toggle_time > 1;
    }
//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_rx_seq_item");
        super.new();
        `uvm_info("[SEQ_ITEM]","constructor",UVM_HIGH)
    endfunction: new

    //set data_value
    function void set_data(
        input  logic [31:0]  data
    );
        this.data = data;
    endfunction

    //set ready_toggle_time
    function void set_ready_time(
        input int   ready_toggle_time
    );
        this.ready_toggle_time = ready_toggle_time;
    endfunction

    //randomize ready_toggle_time
    function void _randomize();
        int        max_time       = 500;
        int        min_time       = 0;
        this.ready_toggle_time = $urandom_range(max_time,min_time);
    endfunction

    //get data value
    function void get_data(
        output  logic [31:0]       data_out 
    );
        data_out = this.data;
    endfunction: get_data

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction: do_print

    function string convert2string();
        string s;
        s = super.convert2string();
        $sformat(s,"%s %s data = %0d %s",s,BLUE,this.data,WHITE);
        return s;
    endfunction: convert2string

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        udma_rx_seq_item    tr;
        bit eq  =  1'b1;
        if(!$cast(tr,rhs)) begin
            `uvm_fatal("FTR","Illegal do_compare cast")
        end
        eq &= comparer.compare_field("data",this.data, tr.data, $bits(data));
        return eq;
    endfunction: do_compare
endclass : udma_rx_seq_item