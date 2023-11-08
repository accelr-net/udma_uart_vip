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
// FILE         :   uart_udma_checker.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   it takes udma_rx_seq_item from predictor and udma_rx_monitor then compare
//                  both txn give the result
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  25-Oct-2023      Kasun        creation
//
//*******************************************************************************************
class uart_udma_checker extends uvm_scoreboard;
    `uvm_component_utils(uart_udma_checker)

    uvm_analysis_export #(udma_rx_seq_item)                         before_export;
    uvm_analysis_export #(udma_rx_seq_item)                         after_export;

    uvm_analysis_export #(uart_seq_item)                            uart_before_export;                         
    uvm_analysis_export #(uart_seq_item)                            uart_after_export;                         

    uvm_in_order_class_comparator #(udma_rx_seq_item)               comparator;
    uvm_in_order_class_comparator #(uart_seq_item)                  uart_comparator;

//------------------------------------------------------------------------------------------
// Constructor
//------------------------------------------------------------------------------------------
    function new(string name="uart_udma_checker",uvm_component parent);
        super.new(name,parent);
    endfunction: new

//------------------------------------------------------------------------------------------
// Build Phase
//------------------------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        before_export       = new("before_export",this);
        after_export        = new("after_export",this);

        uart_before_export  = new("uart_before_export",this);
        uart_after_export   = new("uart_after_export",this);
        
        comparator          = uvm_in_order_class_comparator #(udma_rx_seq_item)::type_id::create("comparator",this);
        uart_comparator     = uvm_in_order_class_comparator #(uart_seq_item)::type_id::create("uart_comparator",this);
    endfunction: build_phase

//------------------------------------------------------------------------------------------
// Connect Phase
//------------------------------------------------------------------------------------------
    virtual function void connect_phase(uvm_phase phase);
        before_export.connect(comparator.before_export);
        after_export.connect(comparator.after_export);

        uart_before_export.connect(uart_comparator.before_export);
        uart_after_export.connect(uart_comparator.after_export);
    endfunction: connect_phase

//------------------------------------------------------------------------------------------
// Report Phase
//------------------------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        // `uvm_info("[uart_udma_checker]",$sformatf("\n %s matches    : %0d %s",GREEN,comparator.m_matches,WHITE),UVM_LOW)
        // `uvm_info("[uart_udma_checker]",$sformatf("\n %s mismatches : %0d %s",RED,comparator.m_mismatches,WHITE),UVM_LOW)

        // `uvm_info("[udma_uart_checker]",$sformatf("\n %s matches    : %0d %s",GREEN,uart_comparator.m_matches,WHITE),UVM_LOW)
        // `uvm_info("[udma_uart_checker]",$sformatf("\n %s mismatches : %0d %s",RED,uart_comparator.m_mismatches,WHITE),UVM_LOW)
        display_ascii_art_report();
    endfunction: report_phase

    function void display_ascii_art_report();
        string a = { "\n",
        "               +------------------->%sPassed%s \ %sFailed%s <---------------------+         \n",   
        "               |                     %s %0d %s   \ %s %0d %s                          |         \n",  
        "        _______|___________+------------------------------------+_________|_________\n",   
        "           uart_txn        |                                    |        udma_txn   \n",   
        "                    <<=====| uart_tx_o               udma_tx_i  |<<=====            \n",   
        "        ___________________|                                    |___________________\n",   
        "                           |                                    |                   \n",       
        "                           |                                    |                   \n",   
        "                           |          uart_udma_top             |                   \n",       
        "                           |                                    |                   \n",       
        "                           |                                    |                   \n",       
        "        ___________________|                                    |___________________\n",   
        "           uart_txn        |                                    |        udma_txn   \n",   
        "                    =====>>| uart_rx_i               udma_rx_o  |=====>>            \n",   
        "        ___________________|                                    |___________________\n",   
        "               |           +------------------------------------+          |       \n",   
        "               |                                                           |       \n",           
        "               +-----------------> %sPassed%s \ %sFailed%s   <----------------------+       \n",       
        "                                    %s %0d %s \  %s  %0d %s                                \n"           
        };
        $display(a, 
                    GREEN,WHITE,RED,WHITE,GREEN,comparator.m_matches,WHITE,RED,comparator.m_mismatches,WHITE,
                    GREEN,WHITE,RED,WHITE,GREEN,uart_comparator.m_matches,WHITE,RED,uart_comparator.m_mismatches,WHITE
                );
    endfunction: display_ascii_art_report
endclass : uart_udma_checker