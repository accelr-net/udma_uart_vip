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
// FILE         :   uart_uvm_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all svh file for uart RX agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  18-Sep-2023      Kasun        creation
//
//**************************************************************************************************
package uart_uvm_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //includes uvm header goes here
    `include "uart_reg_offsets.svh"
    `include "cfg_seq_item.svh"
    `include "cfg_sequence.svh"
    `include "cfg_driver.svh"
    `include "cfg_monitor.svh"
    `include "udma_cfg_agent.svh"

    `include "uart_seq_item.svh"
    `include "uart_agent_config.svh"
    `include "uart_sequence.svh"
    `include "uart_driver.svh"
    `include "uart_monitor.svh"
    `include "uart_agent.svh"
    
    `include "env_config.svh"
    `include "uart_env.svh"
    `include "uart_test.svh"
endpackage: uart_uvm_pkg