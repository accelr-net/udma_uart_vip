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
// FILE         :   udma_tx_driver.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is for udma_rx agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  4-Nov-2023      Kasun        creation
//
//**************************************************************************************************
class udma_tx_driver extends uvm_driver;
    `uvm_component_utils(udma_tx_driver)

    virtual udma_if         vif;

//--------------------------------------------------------------------------------------------------
// Constructor 
//--------------------------------------------------------------------------------------------------
    function new(string name="udma_tx_driver",uvm_component parent);
        super.new(name,parent);
    endfunction: new

//--------------------------------------------------------------------------------------------------
// Build Phase 
//--------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual udma_if)::get(this,"","vif",vif)) begin
            `uvm_fatal("[udma_tx_driver]","No virtual interface found!")
        end
    endfunction: build_phase

//--------------------------------------------------------------------------------------------------
// Run Phase 
//--------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        udma_tx_seq_item        udma_tx_transaction;
        super.run_phase(phase);
        `uvm_info("[udma_tx_driver]","run_phase",UVM_HIGH)
        repeat(5) begin
            udma_tx_transaction = udma_tx_seq_item::type_id::create("udma_tx_txn");
            seq_item_port.get_next_item(udma_tx_transaction);
            do_udma_tx(udma_tx_transaction);
            seq_item_port.item_done();
        end
    endtask

    task do_udma_tx(udma_tx_seq_item txn);
        @(vif.tx_data_cbd);
        this.vif.tx_data_cbd.data_tx_i <= txn.data;
    endtask: do_udma_tx
endclass 