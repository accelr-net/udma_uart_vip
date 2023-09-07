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
// FILE         :   cfg_env.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm environment for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  25-Aug-2023      Kasun        creation
//
//**************************************************************************************************
class cfg_env extends uvm_env;
    `uvm_component_utils(cfg_env);

    cfg_agent           cfg_agnt;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_env", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[DRIVER]","constructor", UVM_MEDIUM)
    endfunction:new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In Build_phase - construct agent and get virtual interface handle from test and pass it down to agent
    function void build_phase(uvm_phase phase);
        `uvm_info("[DRIVER]","build_phase", UVM_MEDIUM)
        cfg_agnt   = cfg_agent::type_id::create("cfg_agnt",this);
    endfunction: build_phase
endclass: cfg_env