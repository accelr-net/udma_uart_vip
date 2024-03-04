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

package cmd_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //cmd header files
    `include "cmd_seq_item.svh"
    `include "cmd_agent_config.svh"
    `include "cmd_sequence.svh"
    `include "cmd_monitor.svh"
    `include "cmd_driver.svh"
    `include "cmd_agent.svh"
endpackage: cmd_agent_pkg