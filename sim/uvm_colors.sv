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
// FILE         :   uvm_colors.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence object for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  12-oct-2023      Kasun        creation
//
//**************************************************************************************************
package uvm_colors;
    const string      RED              = "\033[0;31m";
    const string      GREEN            = "\033[0;32m";
    const string      YELLOW           = "\033[0;33m";
    const string      BLUE             = "\033[0;34m";
    const string      PURPLE           = "\033[0;35m";
    const string      WHITE            = "\033[0;37m";
    const string      LIGHTRED         = "\033[1;31m";
    const string      LIGHTGREEN       = "\033[1;32m";
    const string      LIGHTYELLOW      = "\033[1;33m";
    const string      LIGHTBLUE        = "\033[1;34m";
    const string      LIGHTPURPLE      = "\033[1;35m";
endpackage: uvm_colors