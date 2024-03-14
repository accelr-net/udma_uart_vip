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
// FILE         :   udma_tx_sequence.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_tx_sequence 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  4-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class udma_tx_sequence extends uvm_sequence;
    `uvm_object_utils(udma_tx_sequence)

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_sequence");
        super.new(name);
        `uvm_info("[SEQUENCE]","constructor",UVM_HIGH);
    endfunction

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        udma_tx_seq_item    udma_tx_transaction;
        forever begin
            udma_tx_transaction = udma_tx_seq_item::type_id::create("udma_tx_transaction");
            start_item(udma_tx_transaction);
            udma_tx_transaction.randomize();
            finish_item(udma_tx_transaction);
        end
    endtask: body
endclass