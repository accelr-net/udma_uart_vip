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
// FILE         :   TX_enable_test_disable.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   Test with TX Disable end RX enable 
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

//ToDo: change file name TX -> tx
class TX_enable_test_disable extends uart_test;
    `uvm_component_utils(TX_enable_test_disable);

    bit    tx_ena = 1'b0;

    function new(string name="TX_enable_test_disable",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
       super.set_tx_ena(tx_ena);
       super.build_phase(phase);
    endfunction: build_phase

endclass: TX_enable_test_disable