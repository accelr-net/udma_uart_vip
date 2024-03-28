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
// PROJECT      :   SPI Verification Env
// PRODUCT      :   N/A
// FILE         :   spi_base_test.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is uvm sequence item for spi command. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  28-Feb-2024     Kasun         creation
//
//**************************************************************************************************

class spi_base_test extends uvm_test;
    `uvm_component_utils(spi_base_test)

    //default values
    logic               cpol                    = 1'b0;
    logic               cpha                    = 1'b0;
    logic   [1:0]       chip_select             = 2'b01;
    logic               is_lsb                  = 1'b0;
    logic   [3:0]       word_size               = 4'h7;
    logic   [15:0]      word_count              = 16'h5;
    logic   [7:0]       clkdiv                  = 8'd100;

    bit                 is_atomic_test          = 1'b1;
    logic   [2:0]       communication_mode      = 3'b001;

    spi_env             env;
    env_configs         env_config_obj;

//------------------------------------------------------------------------------------------------------------------
// Set cmd parameters
//------------------------------------------------------------------------------------------------------------------
    virtual function void set_cpol(bit cpol);
        this.cpol               = cpol;
    endfunction : set_cpol

    virtual function void set_cpha(bit cpha);
        this.cpha               = cpha;
    endfunction : set_cpha

    virtual function void set_chip_select(logic [1:0] chip_select);
        this.chip_select        = chip_select;
    endfunction: set_chip_select

    virtual function void set_lsb(bit is_lsb);
        this.is_lsb             = is_lsb;
    endfunction : set_lsb

    virtual function void set_word_size(logic [3:0] word_size);
        this.word_size          = word_size;
    endfunction: set_word_size

    virtual function void set_word_count(logic [15:0]   word_count);
        this.word_count         = word_count;
    endfunction: set_word_count

    virtual function void set_clkdiv(logic [7:0] clkdiv);
        this.clkdiv             = clkdiv;
    endfunction : set_clkdiv

    virtual function void set_atomic_test(bit is_atomic_test);
        this.is_atomic_test     = is_atomic_test;
    endfunction: set_atomic_test

    virtual function void set_communication_mode(logic [2:0] communication_mode);
        this.communication_mode = communication_mode;
    endfunction: set_communication_mode

//------------------------------------------------------------------------------------------------------------------
// Constructor
//------------------------------------------------------------------------------------------------------------------
    function new(string name="spi_base_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("[spi_base_test]","constructor", UVM_LOW)
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info("[spi_test]","build_phase", UVM_LOW)
 
        env                 = spi_env::type_id::create("env",this);
        env_config_obj      = env_configs::type_id::create("env_config_obj",this);

        env_config_obj.cpol                 = cpol;
        env_config_obj.cpha                 = cpha;
        env_config_obj.chip_select          = chip_select;
        env_config_obj.is_lsb               = is_lsb;
        env_config_obj.word_size            = word_size;
        env_config_obj.clkdiv               = clkdiv;
        env_config_obj.is_atomic_test       = is_atomic_test;
        env_config_obj.communication_mode   = communication_mode;

        //putting configuration to the db
        uvm_config_db #(logic)::set(null,"*","cpol",cpol);
        uvm_config_db #(logic)::set(null,"*","cpha",cpha);
        uvm_config_db #(logic [1:0])::set(null,"*","chip_select",chip_select);
        uvm_config_db #(logic)::set(null,"*","is_lsb",is_lsb);
        uvm_config_db #(logic [3:0])::set(null,"*","word_size",word_size);
        uvm_config_db #(logic [15:0])::set(null,"*","word_count",word_count);
        uvm_config_db #(logic [7:0])::set(null,"*","clkdiv",clkdiv);

        uvm_config_db #(env_configs)::set(this,"env","env_configs",env_config_obj);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        spi_cfg_rx_only_cmd_sequence            rx_cmd_sequence;
        spi_cfg_tx_only_cmd_sequence            tx_cmd_sequence;
        spi_cfg_fullduplex_cmd_sequence         fullduplex_sequence;

        udma_tx_sequence                        udma_tx_seq;
        udma_rx_sequence                        udma_rx_seq;
        spi_sequence                            spi_seq;

        `uvm_info("[spi_base_test]","run_phase", UVM_LOW)

        if(is_atomic_test) begin
            case(communication_mode)
                3'b001 : begin
                    //rx command sequence
                    phase.raise_objection(this,"Strating cmd rx sequence");    
                    rx_cmd_sequence = spi_cfg_rx_only_cmd_sequence::type_id::create("spi_cfg_rx_only_cmd_sequence"); // ToDo : change the name rx_cmd_sequence
                    spi_seq     = spi_sequence::type_id::create("spi_sequence");
                    udma_rx_seq = udma_rx_sequence::type_id::create("udma_tx_sequence");
                    rx_cmd_sequence.start(env.cmd_agnt.sequencer);
                    phase.drop_objection(this);

                    //rx data sequence
                    phase.raise_objection(this,"starting rx_data sequence");
                    fork 
                        // spi rx sequence
                        spi_seq.start(env.spi_rx_agnt.sequencer);
                        // udma rx sequence
                        udma_rx_seq.start(env.udma_rx_agnt.sequencer);

                    join_any
                    phase.drop_objection(this);
                end
                3'b010 : begin
                    //tx command sequence
                    phase.raise_objection(this,"Strating cmd tx sequence");    
                    tx_cmd_sequence = spi_cfg_tx_only_cmd_sequence::type_id::create("spi_cfg_tx_only_cmd_sequence");
                    udma_tx_seq = udma_tx_sequence::type_id::create("udma_tx_sequence");
                    udma_rx_seq = udma_rx_sequence::type_id::create("udma_tx_sequence");
                    spi_seq     = spi_sequence::type_id::create("spi_sequence");
                    tx_cmd_sequence.start(env.cmd_agnt.sequencer);
                    `uvm_info("spi_test_base","starting spi_seq",UVM_LOW)
                    fork
                        // udma tx data flow 
                        udma_tx_seq.start(env.udma_tx_agnt.sequencer);
                        // udma rx data flow
                        udma_rx_seq.start(env.udma_rx_agnt.sequencer);
                        //spi tx data flow
                        spi_seq.start(env.spi_rx_agnt.sequencer);
                    join_any
                    phase.drop_objection(this);
                end
                3'b100 : begin
                    phase.raise_objection(this,"Strating cmd fullduplex sequence");    
                    fullduplex_sequence = spi_cfg_fullduplex_cmd_sequence::type_id::create("spi_cfg_fullduplex_cmd_sequence");
                    fullduplex_sequence.start(env.cmd_agnt.sequencer);
                    phase.drop_objection(this);
                end
                default : begin
                    $display("didn't implemented");
                end
            endcase
        end
    endtask: run_phase

endclass: spi_base_test