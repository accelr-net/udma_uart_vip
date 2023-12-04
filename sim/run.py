#************************************************************************************************
#
#Copyright(C) 2023 ACCELR
#All rights reserved.
#
#THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
#ACCELER LOGIC (PVT) LTD, SRI LANKA.
#
#This copy of the Source Code is intended for ACCELR's internal use only and is
#intended for view by persons duly authorized by the management of ACCELR. No
#part of this file may be reproduced or distributed in any form or by any
#means without the written approval of the Management of ACCELR.
#
#ACCELR, Sri Lanka            https://accelr.lk
#No 175/95, John Rodrigo Mw,  info@accelr.net
#Katubedda, Sri Lanka         +94 77 3166850
#
#************************************************************************************************
#
#PROJECT      :   UART Verification Env
#PRODUCT      :   N/A
#FILE         :   uart_env.svh
#AUTHOR       :   Kasun Buddhi
#DESCRIPTION  :   This is contain all svh file for uart RX agent
#
#************************************************************************************************
#
#REVISIONS:
#
# Date            Developer     Descriptio
# -----------     ---------     -----------
# 23-Nov-2023      Kasun        creation
#
#*************************************************************************************************
import subprocess
from tqdm import tqdm


#------------------------------------------------------------------------------------------------
# Add tests into test_list list
#------------------------------------------------------------------------------------------------
test_list = [
    "uart_base_test",
    "baud_rate_9600_test",
    "baud_rate_19200_test",
    "char_length_5_test",
    "char_length_6_test",
    "char_length_7_test",
    "parity_en_enable_test",
    "rx_enable_disable_test",
    "stop_bits_2_test",
    "tx_enable_disable_test"
]

def check_error_code(code,text):
    if(code in text):
        return False
    else:
        return True

for index in tqdm(range(len(test_list))):
    test = test_list[index]
    is_error = True
    clean       =   subprocess.run(["make","clean"],capture_output=True)
    output_text =   subprocess.run(["make","all",("TEST_NAME="+test)],capture_output=True)
    output_arr  =   output_text.stdout.split(b'\n')
    is_error    &=  check_error_code(b'# ** Fatal: Error_code : comparator_mismatches_1',output_arr)
    is_error    &=  check_error_code(b'# ** Fatal: Error_code : udma_comparator_matches_2',output_arr)
    # Stop the process
    if(not is_error):
        print("========================")
        print("Failed one or more tests")
        print("========================")
        break

if(is_error):
    print("================")
    print("Passed all tests")
    print("================")