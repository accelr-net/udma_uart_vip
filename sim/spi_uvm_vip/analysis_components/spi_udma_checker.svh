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
// FILE         :   spi_udma_checker.svh
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

class spi_udma_checker extends uvm_scoreboard;
    `uvm_component_utils(spi_udma_checker)

    uvm_analysis_export     #(udma_rx_seq_item)         udma_before_export;
    uvm_analysis_export     #(udma_rx_seq_item)         udma_after_export;

    uvm_analysis_export     #(spi_seq_item)             spi_before_export;
    uvm_analysis_export     #(spi_seq_item)             spi_after_export;

    uvm_in_order_class_comparator #(udma_rx_seq_item)   udma_comparator;
    uvm_in_order_class_comparator #(spi_seq_item)       spi_comparator;
    function new(string name="spi_udma_checker",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);

        udma_before_export      = new("udma_before_export",this);
        udma_after_export       = new("udma_after_export",this);

        spi_before_export       = new("spi_before_export",this);
        spi_after_export        = new("spi_after_export",this);

        udma_comparator         = uvm_in_order_class_comparator #(udma_rx_seq_item)::type_id::create("udma_comparator",this);
        spi_comparator          = uvm_in_order_class_comparator #(spi_seq_item)::type_id::create("spi_comparator",this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        //connecting udma_rx comparator
        udma_before_export.connect(udma_comparator.before_export);
        udma_after_export.connect(udma_comparator.after_export);

        //connecting spi comparator
        spi_before_export.connect(spi_comparator.before_export);
        spi_after_export.connect(spi_comparator.before_export);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            #(100);
            $display("udma_comparator.m_mismaches %d",udma_comparator.m_mismaches);
        end
    endtask : run_phase
endclass