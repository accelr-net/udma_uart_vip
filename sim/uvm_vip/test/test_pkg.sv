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
// FILE         :   test_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all uvm_test files
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  11-oct-2023      Kasun        creation
//
//**************************************************************************************************
package test_pkg;
    import       uvm_pkg::*;
    `include     "uvm_macros.svh"

    import       uart_agent_pkg::*;
    import       udma_cfg_agent_pkg::*;
    import       udma_rx_agent_pkg::*;
    import       udma_tx_agent_pkg::*;
    import       env_pkg::*;

    `include     "uart_base_test.svh"
    `include     "baud_rate_9600_test.svh"
    `include     "baud_rate_19200_test.svh"
    `include     "baud_rate_38400_test.svh"
    `include     "char_length_5_test.svh"
    `include     "char_length_6_test.svh"
    `include     "char_length_7_test.svh"
    `include     "parity_en_enable_test.svh"
    `include     "rx_enable_disabled_test.svh"
    `include     "tx_enable_disabled_test.svh"
    `include     "stop_bits_2_test.svh"
    `include     "parity_en_enable_char_length_5_test.svh"
    `include     "stop_bits_2_char_length_5_test.svh"
    `include     "parity_en_enable_error_inject_test.svh"
endpackage: test_pkg