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
    cfg_agent_config    config_obj;
    int                 frequency;
    int                 baud_rate;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_sequence");
        super.new(name);
        if(!uvm_config_db #(int)::get(null,"*","baud_rate",baud_rate)) begin
            `uvm_fatal("Cannot find baud_rate","give sutable baud_rate");
        end
        if(!uvm_config_db #(int)::get(null, "*","frequency",frequency)) begin
            `uvm_fatal("Cannot find frequency","set frequency to config_db");
        end
        if(baud_rate == 0) begin
            `uvm_fatal("Zero divition erro","please give value to baud_rate")
        end
        `uvm_info("[SEQUENCE]","constructor", UVM_LOW)
    endfunction : new

//---------------------------------------------------------------------------------------------------------------------
// Body
//---------------------------------------------------------------------------------------------------------------------
    task body();
        cfg_seq_item        cfg_item;
        int                 clkdiv;
        logic [31:0]        setup_value;
        
        uart_reg_offsets    reg_offsets;
        clkdiv  = frequency/baud_rate; 
        reg_offsets = new();
        setup_value = {clkdiv[15:0],16'h0306};
        `uvm_info("[SEQUENCE]","body",UVM_LOW); 
        cfg_item = cfg_seq_item::type_id::create("cfg_item");

        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.tx_saddr;
        cfg_item.data           <= 32'h1c00934;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.tx_size_addr;
        cfg_item.data           <= 32'h00000080;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.tx_cfg_addr;
        cfg_item.data           <= 32'h00000010;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);

        start_item(cfg_item);
        cfg_item.addr           <= reg_offsets.setup_addr;
        cfg_item.data           <= setup_value;
        cfg_item.rw             <= cfg_seq_item::WRITE;
        finish_item(cfg_item);
    endtask: body
endclass: cfg_sequence