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
// FILE         :   udma_spi_predictor.svh
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

class udma_spi_predictor extends uvm_subscriber #(udma_tx_seq_item);
    `uvm_component_utils(udma_spi_predictor)

    uvm_analysis_port   #(spi_seq_item)     expected_spi_aport;

    function new(string name="udma_spi_predictor",uvm_component parent);
        super.new(name,parent);
        expected_spi_aport  = new("expected_spi_aport",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("udma_spi_predictor","build_phase",UVM_LOW);

    endfunction: build_phase

    virtual function void write(udma_tx_seq_item t);
        spi_seq_item            expected_spi_item;
        logic   [31:0]          data;
        expected_spi_item       = spi_seq_item::type_id::create("expected_spi_item",this);
        t.get_data(data);
        expected_spi_item.set_data(data);

        expected_spi_aport.write(expected_spi_item);
    endfunction: write
endclass: udma_spi_predictor