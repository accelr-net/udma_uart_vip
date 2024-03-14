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
// FILE         :   spi_env_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   this is package for spi uvm environment 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  02-Mar-2024      Kasun        creation
//
//**************************************************************************************************

package spi_env_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import      uvm_colors::*;
    import      cmd_agent_pkg::*;
    import      udma_tx_agent_pkg::*;

    `include "env_configs.svh"
    `include "spi_cfg_rx_only_cmd_sequence.svh"
    `include "spi_cfg_tx_only_cmd_sequence.svh"
    `include "spi_cfg_fullduplex_cmd_sequence.svh"
    `include "spi_env.svh"
endpackage : spi_env_pkg