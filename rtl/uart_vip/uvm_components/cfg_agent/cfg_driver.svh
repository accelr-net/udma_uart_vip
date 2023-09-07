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
// FILE         :   cfg_driver.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm driver for cfg. 
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
class cfg_driver extends uvm_driver #(cfg_seq_item);
    `uvm_component_utils(cfg_driver)
    virtual udma_if vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name = "cfg_driver", uvm_component parent);
        super.new(name,parent);
        $display("[DRIVER] - constructor");
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual udma_if)::get(this, "*", "vif",vif)) begin
            `uvm_fatal("cfg_driver/build_phase","No virtual interface specified for this driver instance");
        end
        $display("[DRIVER] - build_phase");
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("[DRIVER] - run_phase");
        forever begin
            cfg_seq_item cfg_transaction;
            $display("[DRIVER] - after create cfg_transaction variable");

            //First get an item from sequencer
            // seq_item_port.get_next_item(cfg_transaction);
            cfg_transaction = cfg_seq_item::type_id::create("cfg_transaction");
            $display("[DRIVER] - after line 79");

            seq_item_port.get_next_item(cfg_transaction);
            $display("[DRIVER] - after called get_next_item v: %s",cfg_transaction.rw.name());
            
            uvm_report_info("CFG_DRIVER","Transaction has sent");
            if(cfg_transaction.rw.name() == "WRITE") begin
                drive(cfg_transaction);
            end
            seq_item_port.item_done();
        end
    endtask : run_phase

    task drive(cfg_seq_item transaction);
        @(posedge vif.sys_clk_i);

        vif.cfg_addr_i      <= transaction.addr;
        vif.cfg_data_i      <= transaction.data;
        vif.cfg_rwn_i       <= 1'b1;
        vif.cfg_valid_i     <= 1'b1;
    endtask: drive

    //should remove this task after testing
    virtual protected task do_configs();
        $display("[DRIVER] - do_configs");
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h09;
        vif.cfg_data_i          <= 32'h01b10306;
        vif.cfg_rwn_i           <= 1'b0;
        @(posedge vif.sys_clk_i);
        vif.cfg_valid_i         <= 1'b1;
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h00;
        vif.cfg_data_i          <= 32'h00;
        vif.cfg_rwn_i           <= 1'b1;
        vif.cfg_valid_i         <= 1'b0;

        // TX_addr as example 43661000000
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h04;
        vif.cfg_data_i          <= 32'h1c000934;
        vif.cfg_rwn_i           <= 1'b0;
        @(posedge vif.sys_clk_i);
        vif.cfg_valid_i         <= 1'b1;
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h00;
        vif.cfg_data_i          <= 32'h00;
        vif.cfg_rwn_i           <= 1'b1;
        vif.cfg_valid_i         <= 1'b0;

        // tx buffer size as example 4366200
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h05;
        vif.cfg_data_i          <= 32'h00000080;
        vif.cfg_rwn_i           <= 1'b0;
        @(posedge vif.sys_clk_i);
        vif.cfg_valid_i         <= 1'b1;
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h00;
        vif.cfg_data_i          <= 32'h00;
        vif.cfg_rwn_i           <= 1'b1;
        vif.cfg_valid_i         <= 1'b0;

        // TX_CFG as example  
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h06;
        vif.cfg_data_i          <= 32'h00000010;
        vif.cfg_rwn_i           <= 1'b0;
        @(posedge vif.sys_clk_i);
        vif.cfg_valid_i         <= 1'b1;
        @(posedge vif.sys_clk_i);
        vif.cfg_addr_i          <= 5'h00;
        vif.cfg_data_i          <= 32'h00;
        vif.cfg_rwn_i           <= 1'b1;
        vif.cfg_valid_i         <= 1'b0;
    endtask: do_configs

endclass: cfg_driver