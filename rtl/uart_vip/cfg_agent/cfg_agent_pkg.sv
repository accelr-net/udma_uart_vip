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
// FILE         :   cfg_agent_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is included all uvm svh files for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  05-Sep-2023      Kasun        creation
//
//**************************************************************************************************
package cfg_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //includes uvm header goes here
    `include "cfg_seq_item.svh"
    `include "cfg_sequence.svh"
    `include "cfg_driver.svh"
    `include "cfg_monitor.svh"
    `include "cfg_agent.svh"
    `include "cfg_env.svh"
    `include "cfg_test.svh"
endpackage: cfg_agent_pkg