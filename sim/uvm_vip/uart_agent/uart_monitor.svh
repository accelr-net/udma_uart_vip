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
// FILE         :   uart_monitor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm monitor for uart RX. 
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
class uart_monitor extends uvm_monitor;
    `uvm_component_utils(uart_monitor)

    virtual uart_if                          uart_vif;
    
    uart_agent_config                        rx_config;
    int                                      uart_period;
    uvm_analysis_port #(uart_seq_item)       uart_rx_aport;

    function new(string name="uart_monitor", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[monitor]", "constructor", UVM_HIGH)

        uart_rx_aport   = new("uart_rx_aport",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("MONITOR","build_phase", UVM_HIGH)
        if(!uvm_config_db #(virtual uart_if)::get(this, "","uart_vif",uart_vif)) begin
            `uvm_fatal("[MONITOR]","No virtual interface specified for this monitor instance")
        end

        if(!uvm_config_db #(uart_agent_config)::get(this,"*","uart_config",rx_config)) begin
            `uvm_fatal("[MONITOR]","Cannot find uart_config. Please give configs from tb_top");
        end
        calculate_uart_period(rx_config.baud_rate);
    endfunction

    function void calculate_uart_period(int baud_rate);
        if(baud_rate != 0) begin
            this.uart_period = 10**9/baud_rate;
        end else begin
            `uvm_fatal("uart_driver/calculate_uart_period","Please set baud_rate with non zero value");
        end
    endfunction: calculate_uart_period;

    virtual task run_phase(uvm_phase phase);
        uart_seq_item   uart_rx_transaction;
        super.run_phase(phase);
        `uvm_info("[MONITOR]","run_phase",UVM_HIGH)
        forever begin
            bit                              parity;
            bit                              parity_en;
            bit [7:0]                        character;
            //create a transaction object 
            uart_rx_transaction = uart_seq_item::type_id::create("uart_rx_transaction",this);
            uart_rx_transaction.set_character_length(rx_config.char_length);
            if(rx_config.is_rx_agent) begin
                @(negedge uart_vif.uart_rx_i);
            end else begin
                @(negedge uart_vif.uart_tx_o);
            end
            #(this.uart_period/2);   // purpose is to check in the middle of the half clock (middle of the pulse)
            #this.uart_period;       // wait for start_bit
            //get character
            for(int i=0; i < rx_config.char_length; i++) begin
                character[i] = rx_config.is_rx_agent? uart_vif.uart_rx_i:  uart_vif.uart_tx_o;
                if(i != rx_config.char_length - 1) begin
                    #this.uart_period;
                end
            end

            //get parity
            if(rx_config.parity_en == 1'b1) begin
                #(this.uart_period);
                parity_en = 1'b1;
                parity   = rx_config.is_rx_agent? uart_vif.uart_rx_i:uart_vif.uart_tx_o;
            end else begin
                parity_en = 1'b0;
            end
            //set character and parity
            uart_rx_transaction.set_data(character,parity_en,parity);
            //delay for 2 stopbits 
            if(rx_config.stop_bits == 2) begin
                #this.uart_period;
            end
            #(this.uart_period/2); // wait for stop
            uart_rx_aport.write(uart_rx_transaction);
        end
    endtask: run_phase
endclass: uart_monitor