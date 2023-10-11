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
// FILE         :   test_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all uvm_test files
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  11-oct-2023      Kasun        creation
//
//**************************************************************************************************
package test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import uart_agent_pkg::*;
    import cfg_agent_pkg::*;
    import env_pkg::*;

    `include "uart_test.svh"
endpackage: test_pkg