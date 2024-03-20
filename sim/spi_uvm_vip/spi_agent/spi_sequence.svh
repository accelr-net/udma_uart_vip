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
// FILE         :   spi_sequence.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is spi uvm sequence. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  15-Mar-2024     Kasun         creation
//
//**************************************************************************************************

class spi_sequence extends uvm_sequence #(spi_seq_item);
    `uvm_object_utils(spi_sequence)

    function new(string name="spi_sequence");
        super.new(name);
    endfunction: new

    task body();
        spi_seq_item    spi_txn;

        spi_txn = spi_seq_item::type_id::create("spi_txn");

        repeat (100) begin
            start_item(spi_txn);
            finish_item(spi_txn);
        end

    endtask: body
endclass : spi_sequence