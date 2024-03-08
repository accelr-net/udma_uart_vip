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
//  28-Feb-2024     Kasun         creation
//
//**************************************************************************************************

class env_configs extends uvm_object;
    `uvm_object_utils(env_configs)

    bit                 cpol = 1'b1;
    logic               cpha;
    logic   [1:0]       chip_select;
    logic               is_lsb;
    logic   [3:0]       word_size;
    logic   [15:0]      word_count;
    logic   [7:0]       clkdiv;

    bit                 is_atomic_test;
    logic   [2:0]       communication_mode;

    function new(string name="env_configs");
        super.new(name);
        `uvm_info("[env_config]","constructor",UVM_LOW);
    endfunction: new
endclass