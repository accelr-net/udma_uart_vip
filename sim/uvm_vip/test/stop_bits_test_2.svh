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
// FILE         :   stop_bits_test_2.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   Test with RX Disable end TX enable 
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
class stop_bits_test_2 extends uart_test;
    `uvm_component_utils(stop_bits_test_2)

    int stop_bits = 2;

    function new(string name="stop_bits_test_2",uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        super.set_stop_bits(stop_bits);
        super.build_phase(phase);
    endfunction: build_phase
endclass: stop_bits_test_2