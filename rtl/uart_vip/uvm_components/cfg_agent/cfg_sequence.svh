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
        `uvm_info("[SEQUENCE]","constructor", UVM_MEDIUM)
    endfunction : new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        $display("[cfg_sequence] - at body task");
        cfg_item = cfg_seq_item::type_id::create("cfg_item");

        start_item(cfg_item);
        cfg_item.addr           <= 5'h09;
        cfg_item.data           <= 32'h01b10306;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= 5'h04;
        cfg_item.data           <= 32'h1c00934;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= 5'h05;
        cfg_item.data           <= 32'h00000080;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= 5'h06;
        cfg_item.data           <= 32'h00000010;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);
    endtask: body
endclass: cfg_sequence