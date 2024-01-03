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
// FILE         :   uart_udma_predictor.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is take uart_seq_item from analysis export then make udma_seq_item and 
//                  put on another analysis port 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  25-Oct-2023      Kasun        creation
//
//**************************************************************************************************

class uart_udma_predictor extends uvm_subscriber #(uart_seq_item);
    `uvm_component_utils(uart_udma_predictor)

    uvm_analysis_port   #(udma_rx_seq_item)     expected_udma_aport;
    bit                                         error_inject_enabled = 1'b0;

    function new(string name="uart_udma_predictor",uvm_component parent);
        super.new(name,parent);
        expected_udma_aport = new("expected_udma_aport",this);
        if(!uvm_config_db #(bit)::get(this,"","parity_error",error_inject_enabled)) begin
            `uvm_fatal("uart_driver/build_phase","Please set error_inject_enabled config");
        end
    endfunction: new

    virtual function void write(uart_seq_item t);
        udma_rx_seq_item                            expected_udma_item;
        bit     [7:0]                               character;
        bit                                         parity;
        bit                                         expected_parity;
        expected_udma_item      = udma_rx_seq_item::type_id::create("expected_udma_txn",this);
        //make expected_udma_txn here
        t.get_data(character);
        expected_udma_item.set_data(character);

        if(error_inject_enabled) begin
            t.get_parity(parity);
            t.calculate_parity();
            t.get_parity(expected_parity);
            if(parity == expected_parity) begin
                expected_udma_aport.write(expected_udma_item);
            end
        end else begin
            //write expected_udma_txn into analysis port
            expected_udma_aport.write(expected_udma_item);
        end
    endfunction: write

endclass: uart_udma_predictor