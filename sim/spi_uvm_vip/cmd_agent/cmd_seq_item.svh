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
// PROJECT      :   SPI Verification Env
// PRODUCT      :   N/A
// FILE         :   cmd_seq_item.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence item for spi command. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  20-Feb-2024     Kasun         creation
//
//**************************************************************************************************
class cmd_seq_item extends uvm_sequence_item;
    `uvm_object_utils(cmd_seq_item)

    logic       [31:0]      data;

    function new(string name="cmd_seq_item");
        super.new(name);
    endfunction: new

    //set the value of the command
    function void set_data(
        input [31:0]   data
    );
        this.data = data;
    endfunction: set_data

    //get value of the command
    function void get_data(
        output logic [31:0]    data
    );
        data = this.data;
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
        cmd_seq_item    tr;
        bit eq = 1'b1;
        if(!$cast(tr,rhs)) begin
            `uvm_fatal("FTR","Illegal do_compare cast")
        end
        eq &= comparer.compare_field("data",this.data, tr.data, $bits(data));
        return eq;
    endfunction: do_compare

endclass: cmd_seq_item