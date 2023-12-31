// ************************************************************************************************
//
// Copyright 2023, Acceler Logic (Pvt) Ltd, Sri Lanka
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   UART Verification Env
// PRODUCT      :   N/A
// FILE         :   uart_driver.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm driver for uart RX. 
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
class uart_driver extends uvm_driver #(uart_seq_item);
    `uvm_component_utils(uart_driver)
    virtual uart_if         uart_vif;
    int                     uart_period;
    bit                     error_inject_enabled = 1'b0;

    uart_agent_config       rx_config;

//---------------------------------------------------------------------------------------------------------------------
// Constructor
//---------------------------------------------------------------------------------------------------------------------
    function new(string name="uart_driver", uvm_component parent);
        super.new(name,parent);
    endfunction: new

//---------------------------------------------------------------------------------------------------------------------
// Build phase
//---------------------------------------------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual uart_if)::get(this,"*","uart_vif",uart_vif)) begin
            `uvm_fatal("uart_driver/build_phase","No virtual interface is found");
        end

        if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_config",rx_config)) begin
            `uvm_fatal("uart_driver/build_phase","Please set uart_rx_configs connot find uart_config from uvm_config_db");
        end

        if(!uvm_config_db #(bit)::get(this,"","parity_error",error_inject_enabled)) begin
            `uvm_fatal("uart_driver/build_phase","Please set error_inject_enabled config");
        end
        `uvm_info("[DRIVER]","build_phase",UVM_HIGH);
        calculate_uart_period(rx_config.baud_rate); // calculate uart_period there
    endfunction: build_phase

//---------------------------------------------------------------------------------------------------------------------
// Connect phase
//---------------------------------------------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("[DRIVER]","connect_phase",UVM_HIGH);
    endfunction: connect_phase

    task configure_phase(uvm_phase phase);
        super.configure_phase(phase);
        `uvm_info("[DRIVER]", "configure_phase", UVM_HIGH)
    endtask : configure_phase

    function void calculate_uart_period(int baud_rate);
        if(baud_rate != 0) begin
            this.uart_period = 10**9/baud_rate;
        end else begin
            `uvm_fatal("uart_driver/calculate_uart_period","Please set baud_rate with non zero value");
        end
    endfunction: calculate_uart_period;
//---------------------------------------------------------------------------------------------------------------------
// Run phase
//---------------------------------------------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        // `uvm_info("[DRIVER]","run_phase",UVM_HIGH)
        uart_seq_item   uart_rx_transaction;
        super.run_phase(phase);
        forever begin
            uart_rx_transaction = uart_seq_item::type_id::create("uart_rx_transaction");
            seq_item_port.get_next_item(uart_rx_transaction);
            do_uart_rx(uart_rx_transaction);
            seq_item_port.item_done();
        end
    endtask: run_phase
    
    task do_uart_rx(uart_seq_item    uart_rx_transaction);
        bit         parity;
        bit [7:0]   character;
        uart_rx_transaction.get_data(character);
        uart_rx_transaction.get_parity(parity);
        #(this.uart_period);
        uart_vif.uart_rx_i = 1'b0; //start bit
        for(int i=0; i < rx_config.char_length; i++) begin
            #(this.uart_period);
            uart_vif.uart_rx_i   = character[i];
        end
        if(rx_config.parity_en == 1'b1) begin
            #(this.uart_period);
            uart_vif.uart_rx_i   = parity;
        end
        for(int j=0; j < rx_config.stop_bits; j++) begin
            #(this.uart_period);
            uart_vif.uart_rx_i = 1'b1; //stop bit
        end
    endtask: do_uart_rx
endclass: uart_driver

