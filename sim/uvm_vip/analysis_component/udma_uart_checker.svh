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
// FILE         :   udma_uart_checker.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   it takes udma_rx_seq_item from predictor and udma_rx_monitor then compare
//                  both txn give the result
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  7-Nov-2023      Kasun        creation
//
//*******************************************************************************************
class udma_uart_checker extends uvm_scoreboard;
    `uvm_component_utils(uart_udma_checker)

    uvm_analysis_export #(udma_tx_seq_item)                         before_export;
    uvm_analysis_export #(udma_tx_seq_item)                         after_export;
    uvm_in_order_class_comparator #(udma_tx_seq_item)               comparator;

    function new(string name="udma_uart_checker",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        before_export = new("before_export",this);
        after_export  = new("after_export",this);

        comparator    = uvm_in_order_class_comparator #(udma_tx_seq_item)::type_id::create("comparator",this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        before_export.connect(comparator.before_export);
        after_export.connect(comparator.after_export);
    endfunction: connect_phase

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("[udma_uart_checker]",$sformatf("\n %s matches    : %0d %s",GREEN,comparator.m_matches,WHITE),UVM_LOW)
        `uvm_info("[udma_uart_checker]",$sformatf("\n %s mismatches : %0d %s",RED,comparator.m_mismatches,WHITE),UVM_LOW)
    endfunction: report_phase
endclass : uart_udma_checker