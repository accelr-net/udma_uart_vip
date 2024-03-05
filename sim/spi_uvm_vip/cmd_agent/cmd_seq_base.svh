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
// FILE         :   cmd_seq_base.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence base class containing send_cmd task for spi command. 
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
class cmd_seq_base extends uvm_sequence;
    `uvm_object_utils(cmd_seq_base)
    // static int      sequence_step;

    function new(string name="cmd_seq_base");
        super.new(name);
    endfunction: new

    task send_cmd(
        input   logic [31:0]     register_offset,
        input   logic [31:0]     data
    );
        // send command
    endtask: send_cmd

    task body();
        cmd_seq_item       cmd_txn;
        
        cmd_txn = cmd_seq_item::type_id::create("cmd_txn");
        start_item(cmd_txn);
        cmd_txn.data    <= 32'h5;
        finish_item(cmd_txn);
    endtask: body

endclass: cmd_seq_base