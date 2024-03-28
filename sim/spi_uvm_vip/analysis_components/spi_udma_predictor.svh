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
// FILE         :   spi_udma_predictor.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   it takes udma_rx_seq_item from predictor and udma_rx_monitor then compare
//                  both txn give the result
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  28-Mar-2024      Kasun        creation
//
//*******************************************************************************************

class spi_udma_predictor extends uvm_subscriber #(spi_seq_item);
    `uvm_component_utils(spi_udma_predictor)  

    uvm_analysis_port   #(udma_rx_seq_item)     expected_udma_aport;

    function new(string name="spi_udma_predictor",uvm_component parent);
        super.new(name,parent);
        expected_udma_aport  = new("expected_udma_aport",this);
    endfunction : new

    virtual function write(spi_seq_item t);
        udma_rx_seq_item                expected_udma_item;
        logic [31:0]                    data;

        expected_udma_item      = udma_rx_seq_item::type_id::create("expected_udma_item",this);
        t.get_data(data);
        expected_udma_item.set_data(data);
        
        //write expected_udma_txn into analysis port
        expected_udma_aport.write(expected_udma_item);
    endfunction: write

endclass : spi_udma_predictor
