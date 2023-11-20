// ************************************************************************************************
//
// Copyright(C) 2023 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   UART Verification Env
// PRODUCT      :   N/A
// FILE         :   char_length_test_7.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   Test with character length = 7
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  15-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class char_length_test_7 extends uart_test;
    `uvm_component_utils(char_length_test_7)

    int char_length  = 7;

    function new(string name="char_length_test_7",uvm_component parent);
        super.new(name,parent);
    endfunction: new 

    function void build_phase(uvm_phase phase);
        super.set_char_length(char_length);
        super.build_phase(phase);
    endfunction: build_phase
endclass: char_length_test_7