// ************************************************************************************************
//
// PROJECT      :   SPI Verification Env
// PRODUCT      :   N/A
// FILE         :   spi_if.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   This is a interface for spi module and outside of the SoC. 
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  22-Aug-2023      Kasun        creation
//
//**************************************************************************************************

//**************************************************************************************************
//                                      PIN DIAGRAM , modports & clocking blocks 
//**************************************************************************************************
//                                                 +-----------------+
//                                                 |                 |<----sys_clk_i
//                                                 |                 |<----periph_clk_i
//                                                 |                 |<----rstn_i
//                                                 |                 |
//                                                 |                 |---->rx_char_event_o 
//                                                 |                 |---->err_event_o
//                                                 |                 |
//                                                 |                 |<----cfg_data_i            <--------+
//                                                 |                 |<----cfg_addr_i                     |
//                                                 |                 |<----cfg_valid_i                    |
//                                                 |                 |<----cfg_rwn_i                      |
//                                                 |                 |---->cfg_ready_o                    |
//                                                 |                 |---->cfg_data_o                     |  
//                                                 |                 |---->cfg_rx_startaddr_o             |
//                                                 |                 |---->cfg_rx_size_o                  |
//                                                 |                 |---->cfg_rx_datasize_o              |
//                                                 |                 |---->cfg_rx_continuous_o            |
//                   +---->          spi_clk_o<----|                 |---->cfg_rx_en_o                    |
//                   |               spi_csn0_o<---|                 |---->cfg_rx_clr_o                   |
//                   |               spi_csn1_o<---|                 |<----cfg_rx_en_i                    | cfg_driver_if
//                   |               spi_csn2_o<---|                 |<----cfg_rx_pending_i               |
//                   |               spi_csn3_o<---|                 |<----cfg_rx_curr_addr_i             |
//                   |               spi_oen0_o<---|                 |<----cfg_rx_bytes_left_i            |
//                   |               spi_oen1_o<---|  udma_spim_top  |---->cfg_tx_startaddr_o             |
//                   |               spi_oen2_o<---|                 |---->cfg_tx_size_o                  |
//          spi_if   |               spi_oen3_o<---|                 |---->cfg_tx_datasize_o              |
//                   |               spi_sdo0_o<---|                 |---->cfg_tx_continuous_o            |
//                   |               spi_sdo1_o<---|                 |---->cfg_tx_en_o                    |
//                   |               spi_sdo2_o<---|                 |---->cfg_tx_clr_o                   |
//                   |               spi_sdo3_o<---|                 |<----cfg_tx_en_i                    |
//                   |               spi_sdi0_i--->|                 |<----cfg_tx_pending_i               |
//                   |               spi_sdi1_i--->|                 |<----cfg_tx_curr_addr_i             |
//                   |               spi_sdi2_i--->|                 |<----cfg_tx_byte_left_i    <--------+
//                   +---->          spi_sdi3_i--->|                 |
//                                                 |                 |---->data_tx_req_o         <--------+
//                                                 |                 |<----data_tx_gnt_i                  |
//                                                 |                 |---->data_tx_datasize_o             | 
//                                                 |                 |<----data_tx_i                      | udma_tx_driver_if
//                                                 |                 |<----data_tx_valid_i                |
//                                                 |                 |---->data_tx_ready_o       <--------+
//                                                 |                 |
//                                                 |                 |---->data_rx_datasize_o    <--------+
//                                                 |                 |---->data_rx_o                      | udma_rx_driver_if
//                                                 |                 |---->data_rx_valid_o                |
//                                                 |                 |<----data_rx_ready_i       <--------+
//                                                 +-----------------+
// 
//*****************************************************************************************************************

interface spi_if;
    logic           spi_clk_o;

    logic           spi_csn0_o;
    logic           spi_oen0_o;
    logic           spi_sdo0_o;
    logic           spi_sdi0_i;

    logic           spi_csn1_o;
    logic           spi_oen1_o;
    logic           spi_sdo1_o;
    logic           spi_sdi1_i;

    logic           spi_csn2_o;
    logic           spi_oen2_o;
    logic           spi_sdo2_o;
    logic           spi_sdi2_i;

    logic           spi_csn3_o;
    logic           spi_oen3_o;
    logic           spi_sdo3_o;
    logic           spi_sdi3_i;

    modport MASTER_PORT_0(
        output      spi_clk_o,
        output      spi_csn0_o,
        output      spi_oen0_o,
        output      spi_sdo0_o,
        input       spi_sdi0_i
    );

    modport MASTER_PORT_1(
        output      spi_clk_o,
        output      spi_csn1_o,
        output      spi_oen1_o,
        output      spi_sdo1_o,
        input       spi_sdi1_i
    );

    modport MASTER_PORT_2(
        output      spi_clk_o,
        output      spi_csn2_o,
        output      spi_oen2_o,
        output      spi_sdo2_o,
        input       spi_sdi2_i
    );

    modport MASTER_PORT_3(
        output      spi_clk_o,
        output      spi_csn3_o,
        output      spi_oen3_o,
        output      spi_sdo3_o,
        input       spi_sdi3_i
    );

    modport SLAVE_PORT_0(
        input       spi_clk_o,
        input       spi_csn0_o,
        input       spi_oen0_o,
        input       spi_sdo0_o,
        output      spi_sdi0_i
    );

    modport SLAVE_PORT_1(
        input       spi_clk_o,
        input       spi_csn1_o,
        input       spi_oen1_o,
        input       spi_sdo1_o,
        output      spi_sdi1_i
    );

    modport SLAVE_PORT_2(
        input       spi_clk_o,
        input       spi_csn2_o,
        input       spi_oen2_o,
        input       spi_sdo2_o,
        output      spi_sdi2_i
    );

    modport SLAVE_PORT_3(
        input       spi_clk_o,
        input       spi_csn3_o,
        input       spi_oen3_o,
        input       spi_sdo3_o,
        output      spi_sdi3_i
    );
endinterface : spi_if