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
// PROJECT      :   udp parser top
// PRODUCT      :   N/A
// FILE         :   udma_sim.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is a vip to uart from udma side
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  10-AUG-2023      Kasun        creation
//
//**************************************************************************************************
module udma_sim #(
    parameter   L2_AWIDTH_NOAL = 12,
    parameter   TRANS_SIZE     = 16
) (
    input   logic         sys_clk_i,
    input   logic         data_tx_req_i,
    input   logic         data_tx_ready_i,

    output  logic         data_tx_gnt_o,
    output  logic [31:0]  data_tx_o,
    output  logic         data_tx_valid_o,
);
    //sending data to uart for tx
    task send_char(input logic [31:0] character);
        if(data_tx_ready_i) begin
            data_tx_o   <= character;
        end
    endtask: send_char

endmodule : udma_sim