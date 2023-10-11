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
// FILE         :   test_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is contain all svh file for uart RX agent
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Descriptio
//  -----------     ---------     -----------
//  18-Sep-2023      Kasun        creation
//
//**************************************************************************************************
package test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import uart_rx_agent_pkg::*;
    import cfg_agent_pkg::*;
    import env_pkg::*;

    // //includes uvm header goes here
    // `include "uart_reg_offsets.svh"
    // `include "cfg_agent_config.svh"
    // `include "cfg_seq_item.svh"
    // `include "cfg_sequence.svh"
    // `include "cfg_driver.svh"
    // `include "cfg_monitor.svh"
    // `include "cfg_agent.svh"

    // `include "uart_rx_seq_item.svh"
    // `include "uart_rx_agent_config.svh"
    // `include "uart_rx_sequence.svh"
    // `include "uart_rx_driver.svh"
    // `include "uart_rx_monitor.svh"
    // `include "uart_rx_agent.svh"
    // `include "uart_subscriber.svh"
    
    // `include "env_config.svh"
    // `include "uart_env.svh"
    `include "uart_test.svh"
endpackage: test_pkg