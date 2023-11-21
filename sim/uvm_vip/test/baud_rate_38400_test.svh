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
// FILE         :   baud_rate_38400_test.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   Test with baud_rate with 38400
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  18-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class baud_rate_38400_test extends uart_test;
    `uvm_component_utils(baud_rate_38400_test)

    function new(string name="baud_rate_38400_test",uvm_component parent);
        super.new(name,parent);
        super.set_baud_rate(38400);
    endfunction

endclass: baud_rate_38400_test