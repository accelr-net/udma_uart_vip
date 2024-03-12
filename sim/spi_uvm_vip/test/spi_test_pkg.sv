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
// FILE         :   spi_test_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is packages for spi command. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  01-March-2024     Kasun         creation
//
//**************************************************************************************************
package spi_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import      cmd_agent_pkg::*;
    import      spi_env_pkg::*;

    `include    "spi_base_test.svh"
    `include    "rx_test.svh"
    `include    "tx_test.svh"
    `include    "full_duplex_test.svh"
endpackage: spi_test_pkg