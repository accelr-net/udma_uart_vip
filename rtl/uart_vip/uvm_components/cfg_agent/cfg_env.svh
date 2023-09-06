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
    //virtual interface for udma
    // virtual udma_if     vif; 

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_env", uvm_component parent);
        super.new(name,parent);
        $display("[ENV] - constructor");
    endfunction:new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In Build_phase - construct agent and get virtual interface handle from test and pass it down to agent
    function void build_phase(uvm_phase phase);
        $display("[ENV] - build_phase");
        cfg_agnt   = cfg_agent::type_id::create("cfg_agnt",this);
        // if(!uvm_config_db #(virtual udma_if)::get(this,"*","vif",vif)) begin
        //     `uvm_fatal("cfg_env/build_phase","No virtual interface specified");
        // end
        // uvm_config_db #(virtual udma_if)::set(this,"*","vif",vif);
    endfunction: build_phase
endclass: cfg_env