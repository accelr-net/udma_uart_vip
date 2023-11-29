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
// FILE         :   tx_enable_disable_test.svh
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
class tx_enable_disable_test extends uart_base_test;
    `uvm_component_utils(tx_enable_disable_test);

    function new(string name="tx_enable_disable_test",uvm_component parent);
        super.new(name,parent);
        super.set_tx_ena(1'b0);
    endfunction: new

endclass: tx_enable_disable_test