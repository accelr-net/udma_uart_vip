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
// FILE         :   cfg_test.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm test component for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  31-Aug-2023      Kasun        creation
//
//**************************************************************************************************
class cfg_test extends uvm_test;
    `uvm_component_utils(cfg_test);

    cfg_env env;
    virtual udma_if vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="cfg_test",uvm_component parent);
        super.new(name,parent);
        $display("[TEST] - constructor");
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    //In build phase construct the cfg_env class using factory and
    //Get the virtual interface handle from test then set it config db for the env
    function void build_phase(uvm_phase phase);
        $display("[TEST] - build_phase");
        env = cfg_env::type_id::create("env",this);

        // if(!uvm_config_db #(virtual udma_if)::get(this,"*","vif",vif)) begin
        //     `uvm_fatal("cfg_driver/build_phase","No virtual interface specified");
        // end
        // uvm_config_db #(virtual udma_if)::set(this,"*","vif",vif);
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------   
    //Run phase create an cfg_sequence
    task run_phase(uvm_phase phase);
        // $display("[TEST] - run_phase");
        cfg_sequence    cfg_seq;
        phase.raise_objection(this, "Starting uvm sequence...");
        repeat(5) begin
            cfg_seq = cfg_sequence::type_id::create("cfg_seq");
            cfg_seq.start(env.cfg_agnt.sequencer);
            $display("Starting uvm sequence...");
            #10;
        end
        #1000000;
        phase.drop_objection(this);
    endtask: run_phase

endclass: cfg_test