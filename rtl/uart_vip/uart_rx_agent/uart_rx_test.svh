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
// FILE         :   uart_rx_test.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm test component for cfg. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  11-Sep-2023      Kasun        creation
//
//**************************************************************************************************
class uart_rx_test extends uvm_test;
    `uvm_component_utils(uart_rx_test)

    uart_rx_env         env;
    virtual uart_if     vif;

    function new(string name="uart_rx_test",uvm_component parent);
        super.new(name,parent);
        `uvm_info("[TEST]","constructor",UVM_LOW)
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("[TEST]","build_phase",UVM_LOW)
        env = uart_rx_env::type_id::create("env",this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        uart_rx_sequence    uart_rx_seq;
        phase.raise_objection(this,"Strating uvm sequence");
        repeat(5) begin
            uart_rx_seq = uart_rx_sequence::type_id::create("uart_rx_sequence");
            uart_rx_seq.start(env.agent.sequencer);
            #10;
        end
        #100000;
        phase.drop_objection(this);
    endtask: run_phase
endclass: uart_rx_test