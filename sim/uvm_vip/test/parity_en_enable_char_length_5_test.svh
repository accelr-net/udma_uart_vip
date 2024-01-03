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
// FILE         :   parity_en_enable_char_length_5_test.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   parity enable with char length 5
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  28-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class parity_en_enable_char_length_5_test extends uart_base_test;
    `uvm_component_utils(parity_en_enable_char_length_5_test)

    function new(string name="parity_en_enable_char_length_5_test",uvm_component parent);
        super.new(name,parent);
        super.set_parity_en(1'b1);
        super.set_char_length(5);
    endfunction

endclass: parity_en_enable_char_length_5_test
