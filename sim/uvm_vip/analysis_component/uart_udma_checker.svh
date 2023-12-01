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

    bit         error_inject = 1'b0;

    uvm_analysis_export #(udma_rx_seq_item)                         udma_before_export;
    uvm_analysis_export #(udma_rx_seq_item)                         udma_after_export;

    uvm_analysis_export #(uart_seq_item)                            uart_before_export;                         
    uvm_analysis_export #(uart_seq_item)                            uart_after_export;                         

    uvm_in_order_class_comparator #(udma_rx_seq_item)               udma_comparator;
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
        if(!uvm_config_db #(bit)::get(this,"","parity_error",error_inject)) begin
            `uvm_fatal("uart_driver/build_phase","Please set parity_error_inject config");
        end
        udma_before_export  = new("udma_before_export",this);
        udma_after_export   = new("udma_after_export",this);

        uart_before_export  = new("uart_before_export",this);
        uart_after_export   = new("uart_after_export",this);
        
        udma_comparator     = uvm_in_order_class_comparator #(udma_rx_seq_item)::type_id::create("udma_comparator",this);
        uart_comparator     = uvm_in_order_class_comparator #(uart_seq_item)::type_id::create("uart_comparator",this);
    endfunction: build_phase

//------------------------------------------------------------------------------------------
// Connect Phase
//------------------------------------------------------------------------------------------
    virtual function void connect_phase(uvm_phase phase);
        udma_before_export.connect(udma_comparator.before_export);
        udma_after_export.connect(udma_comparator.after_export);

        uart_before_export.connect(uart_comparator.before_export);
        uart_after_export.connect(uart_comparator.after_export);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("%s run_phase %s",RED,WHITE);
        forever begin
            #(100);
            if(!error_inject) begin
                if(udma_comparator.m_mismatches > 0 || uart_comparator.m_mismatches > 0) begin
                    $display("%s found m_mismatches %s",RED,WHITE);
                    $fatal(1,"Error_code : comparator_mismatches_1");
                end
            end else begin
                if(udma_comparator.m_matches > 0) begin
                    $display("%s found m_matches %s",RED,WHITE);
                    $fatal(1,"Error_code : udma_comparator_matches_2");
                end
            end
        end
    endtask:run_phase
//------------------------------------------------------------------------------------------
// Report Phase
//------------------------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        display_ascii_art_report();
    endfunction: report_phase

    function void display_ascii_art_report();
        string a = { "\n",
        "               +-------------------> %sPassed%s \ %sFailed%s <---------------------+         \n",   
        "               |                      %s %0d %s   \ %s %0d %s                         |         \n",  
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
        "               +-------------------> %sPassed%s \ %sFailed%s  <---------------------+       \n",       
        "                                      %s %0d %s \  %s  %0d %s                                \n"           
        };
        $display(a, 
                    GREEN,WHITE,RED,WHITE,GREEN,uart_comparator.m_matches,WHITE,RED,uart_comparator.m_mismatches,WHITE,
                    GREEN,WHITE,RED,WHITE,GREEN,udma_comparator.m_matches,WHITE,RED,udma_comparator.m_mismatches,WHITE
                );
    endfunction: display_ascii_art_report
endclass : uart_udma_checker