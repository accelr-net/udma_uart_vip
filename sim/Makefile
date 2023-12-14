# Copyright 2022 ETH Zurich and University of Bologna
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

mkfile_path := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

VSIM            ?= vsim
VSIM_FLAGS	= -gLOAD_L2=JTAG
VSIM_SUPPRESS   = -suppress vsim-3009 -suppress vsim-8683 -suppress vsim-8386

VLOG            ?= vlog
VLOG_FLAGS      =

VOPT            ?= vopt
VOPT_FLAGS      ?= +acc

VLIB            ?= vlib
VMAP            ?= vmap

# top-level (tesbench)
SIM_TOP     = tb_top 

TEST_NAME	?= uart_base_test
MODE 		?= -c


## Compile RTL with Questasim
all:build run

.PHONY: run
run:
	$(VSIM) $(MODE) -64 vopt_tb \
	+UVM_TESTNAME=$(TEST_NAME) \
	-do run.tcl 

.PHONY: build
build: compile opt

.PHONY: opt
opt:
	$(VOPT) $(VOPT_FLAGS) -o vopt_tb $(SIM_TOP) -work work 

.PHONY: compile
compile:
	$(VSIM) -c -do 'source compile.tcl; quit'


.PHONY: clean
## Remove all compiled RTL
clean:
	$(RM) -r work 
	$(RM) modelsim.ini
	
.PHONY: show_test_list
## Show all uvm test list
show_test_list: 
	echo "example_Test"