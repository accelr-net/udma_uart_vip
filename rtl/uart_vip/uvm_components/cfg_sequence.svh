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
// FILE         :   cfg_sequence.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence object for cfg. 
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
class cfg_sequence extends uvm_sequence; 
    `uvm_object_utils(cfg_sequence)
    cfg_seq_item    cfg_item;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_sequence");
        super.new(name);
        $display("[SEQUENCE] - contructor");
    endfunction : new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        $display("[cfg_sequence] - at body task");
        cfg_item = cfg_seq_item::type_id::create("cfg_item");

        start_item(cfg_item);
        //Write sequence here
        cfg_item.cfg_addr_i     <= 5'h09;
        cfg_item.cfg_data_i     <= 32'h01b10306;
        cfg_item.rw             =  1;
        // cfg_item.randomize();
        finish_item(cfg_item);

        start_item(cfg_item);
        //Write sequence here
        cfg_item.cfg_addr_i     <= 5'h04;
        cfg_item.cfg_data_i     <= 32'h1c000934;
        cfg_item.rw             =  1;
        // cfg_item.randomize();
        finish_item(cfg_item);

        start_item(cfg_item);
        //Write sequence here
        cfg_item.cfg_addr_i     <= 5'h05;
        cfg_item.cfg_data_i     <= 32'h00000080;
        cfg_item.rw             =  1;
        // cfg_item.randomize();
        finish_item(cfg_item);

        start_item(cfg_item);
        //Write sequence here
        cfg_item.cfg_addr_i     <= 5'h06;
        cfg_item.cfg_data_i     <= 32'h00000010;
        cfg_item.rw             =  1;
        // cfg_item.randomize();
        finish_item(cfg_item);
    endtask: body
endclass: cfg_sequence