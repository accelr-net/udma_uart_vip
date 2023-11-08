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
// FILE         :   udma_rx_driver.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is the driver for udma_rx_driver
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  19-Oct-2023      Kasun        creation
//
//**************************************************************************************************
class udma_rx_driver extends uvm_driver #(udma_rx_seq_item);
    `uvm_component_utils(udma_rx_driver)

    virtual udma_if     vif;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="udma_rx_driver", uvm_component parent);
        super.new(name,parent);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual udma_if)::get(this,"*","udma_vif",vif)) begin
            `uvm_fatal("udma_rx_driver","No virtual interface found!");
        end
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        bit                 data_ready = 1'b1;
        udma_rx_seq_item    udma_rx_transaction;
        super.run_phase(phase);
        `uvm_info("[DRIVER]","run_phase",UVM_HIGH);
        forever begin
            udma_rx_transaction = udma_rx_seq_item::type_id::create("uart_rx_transaction");
            seq_item_port.get_next_item(udma_rx_transaction);
            do_udma_rx(udma_rx_transaction,data_ready);
            data_ready = ~data_ready;
            seq_item_port.item_done();
        end
    endtask: run_phase

    task do_udma_rx(udma_rx_seq_item txn,bit data_ready);
        this.vif.rx_data_cbd.data_rx_ready_i   <= data_ready;
        #(txn.ready_toggle_time);
    endtask: do_udma_rx

endclass: udma_rx_driver