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
// FILE         :   spi_agent_config.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is spi agent configs. 
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

class spi_agent_config extends uvm_object;
    `uvm_object_utils(spi_agent_config)

    logic   [3:0]       word_size;

    function new(string name="cmd_agent_config");
        super.new(name);
        `uvm_info("[cmd_agent_config]","constructor",UVM_LOW);
    endfunction: new

endclass: spi_agent_config