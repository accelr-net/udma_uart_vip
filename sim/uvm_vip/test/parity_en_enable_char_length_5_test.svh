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
        super.set_parity_en(1'b0);
        super.set_char_length(5);
    endfunction

endclass: parity_en_enable_char_length_5_test
