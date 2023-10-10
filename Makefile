# Copyright 2020 ETH Zurich and University of Bologna
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

SHELL=bash

CTAGS=ctags

PKG_DIR ?= $(PWD)/install

export VSIM_PATH=$(PKG_DIR)
export PULP_PATH=$(PWD)

define declareInstallFile
$(VSIM_PATH)/$(1): sim/$(1)
	install -v -D sim/$(1) $$@

INSTALL_HEADERS += $(VSIM_PATH)/$(1)
endef

INSTALL_FILES += modelsim.ini
INSTALL_FILES += $(shell cd sim && find boot -type f)
INSTALL_FILES += $(shell cd sim && find tcl_files -type f)
INSTALL_FILES += $(shell cd sim && find waves -type f)
INSTALL_FILES += $(shell cd sim && find work -type f)
INSTALL_FILES += $(shell cd sim && find fs -type f)

$(foreach file, $(INSTALL_FILES), $(eval $(call declareInstallFile,$(file))))

VLOG_ARGS += -suppress 2583 -suppress 13314 \"+incdir+\$$ROOT/rtl/includes\"
BENDER_SIM_BUILD_DIR = sim
BENDER_FPGA_SCRIPTS_DIR = fpga/pulpissimo/tcl/generated

# make variables visible in submake
# don't export variable if undefined/empty
define export_if_def
  ifneq ($(strip $(1)),)
    export $(1)
  endif
endef

export VSIM_PATH

$(export_if_def VSIM)
$(export_if_def VSIM_FLAGS)
$(export_if_def VLOG)
$(export_if_def VLOG_FLAGS)
$(export_if_def SIM_TOP)
$(export_if_def VERILATOR)
$(export_if_def QUESTA)

.DEFAULT_GOAL := all

.PHONY: all
## Checkout, generate scripts and build rtl
all: build

.PHONY: checkout
## Checkout/update dependencies using IPApprox or Bender
checkout: bender
	./bender checkout
	touch Bender.lock
	$(MAKE) scripts

Bender.lock: bender
	./bender checkout
	touch Bender.lock

# generic clean and build targets for the platform
.PHONY: clean
## Remove the RTL model files
clean:
	rm -rf $(VSIM_PATH)
	$(MAKE) -C sim clean

.PHONY: scripts
## Generate scripts for all tools
scripts: scripts-bender-vsim

scripts-bender-vsim: | Bender.lock
	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > $(BENDER_SIM_BUILD_DIR)/compile.tcl
	./bender script vsim \
		--vlog-arg="$(VLOG_ARGS)" --vcom-arg="" \
		-t rtl -t test \
		| grep -v "set ROOT" >> $(BENDER_SIM_BUILD_DIR)/compile.tcl

$(BENDER_SIM_BUILD_DIR)/compile.tcl: Bender.lock
	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > $(BENDER_SIM_BUILD_DIR)/compile.tcl
	./bender script vsim \
		--vlog-arg="$(VLOG_ARGS)" --vcom-arg="" \
		-t rtl -t test \
		| grep -v "set ROOT" >> $(BENDER_SIM_BUILD_DIR)/compile.tcl


.PHONY: build
## Build the RTL model for vsim
build: $(BENDER_SIM_BUILD_DIR)/compile.tcl
	@test -f Bender.lock || { echo "ERROR: Bender.lock file does not exist. Did you run make checkout in bender mode?"; exit 1; }
	@test -f $(BENDER_SIM_BUILD_DIR)/compile.tcl || { echo "ERROR: sim/compile.tcl file does not exist. Did you run make scripts in bender mode?"; exit 1; }
	cd sim && $(MAKE) all


# sdk specific targets
install: $(INSTALL_HEADERS)


.PHONY: import-bootcode
## Import the latest bootcode. This should not be called by the user.
import-bootcode: boot/boot_code_asic.cde
	cp $^ sim/boot/boot_code.cde

boot_code/boot_code_asic.cde:
	$(MAKE) -C boot boot_code.cde

check-env-pulp-gcc:
ifndef PULP_RISCV_GCC_TOOLCHAIN
	$(error PULP_RISCV_GCC_TOOLCHAIN is undefined.\
	You need to set this environment variable to point \
	to your pulp gcc installation)
endif

check-env-art:
ifndef PULP_ARTIFACTORY_USER
	$(error PULP_ARTIFACTORY_USER is undefined.\
	You need to set this environment variable to username:password \
	to be able access the artifactory server to download the sdk)
endif

## Build the pulp SDK from source
build-pulp-sdk: pulp-sdk
pulp-sdk: check-env-pulp-gcc
	git clone https://github.com/pulp-platform/pulp-sdk.git -b 2019.12.06; \
	cd pulp-sdk; \
	source configs/pulpissimo.sh; \
	source configs/platform-rtl.sh; \
	make all env

## Download the latest supported pulp sdk release
pulp-sdk-release: check-env-art sdk-gitlab

.PHONY: get-tests
## Download pulp tests for local machine. Same as test-checkout
get-tests: test-checkout

## fetch sdk for local machine
get-sdk: sdk-gitlab

# GITLAB CI
# continuous integration on gitlab
sdk-gitlab: pkg/sdk/2020.01.01
pkg/sdk/2020.01.01:
	sdk-releases/get-sdk-2020.01.01-CentOS_7.py
	cd pkg; \
	for f in ../sdk-releases/patches/*.patch; do patch -p1 < "$$f"; done; \

# simplified runtime for PULP that doesn't need the sdk
pulp-runtime:
	git clone https://github.com/pulp-platform/pulp-runtime.git -b v0.0.3

.PHONY: test-checkout
## Download pulp test for local machine. You need ssh access to the gitlab server.
test-checkout:
	./update-tests

# the gitlab runner needs a special configuration to be able to access the
# dependent git repositories
.PHONY: test-checkout-gitlab
test-checkout-gitlab:
	./update-tests-gitlab

# test with sdk release
.PHONY: test-gitlab
## Run tests on gitlab using the latest supported sdk release
test-gitlab: tests
	cd tests && plptest --threads 16 --stdout

.PHONY: test-sequential-bare
## Run only sequential_bare tests
test-sequential-bare:
	cd tests/sequential_bare_tests && plptest --threads 32 --stdout

.PHONY: test-parallel-bare
## Run only parallel_bare tests
test-parallel-bare:
	cd tests/parallel_bare_tests && plptest --threads 32 --stdout

.PHONY: test-pulp
## Run only pulp_tests tests
test-pulp:
	cd tests/pulp_tests && plptest --threads 32 --stdout

.PHONY: test-ml
## Run only ml_tests tests
test-ml:
	cd tests/ml_tests && plptest --threads 32 --stdout

.PHONY: test-riscv
## Run only riscv_tests tests
test-riscv:
	cd tests/riscv_tests && plptest --threads 32 --stdout

.PHONY: test-rt
## Run only rt_tests tests
test-rt:
	cd tests/rt-tests && plptest --threads 32 --stdout

.PHONY: test-runtime-gitlab
## Run simplified runtime tests on gitlab using the latest supported sdk release
test-runtime-gitlab: pulp-runtime
	cd tests && ../pulp-runtime/scripts/bwruntests.py --proc-verbose -v \
		--report-junit -t 3600 --yaml \
		-o simplified-runtime.xml runtime-tests.yaml

# test with built sdk
.PHONY: test-gitlab2
test-gitlab2:
	cd pulp-builder; \
	source sdk-setup.sh; \
	source configs/pulpissimo.sh; \
	source configs/rtl.sh; \
	cd ../tests && plptest --threads 16 --stdout

.PHONY: lint
## Generate lint reports with Spyglass
lint:
	$(MAKE) -C spyglass lint_rtl

# Bender integration
bender:
ifeq (,$(wildcard ./bender))
	curl --proto '=https' --tlsv1.2 -sSf https://pulp-platform.github.io/bender/init \
		| bash -s -- 0.25.2
	touch bender
endif

.PHONY: bender-rm
bender-rm:
	rm -f bender

.PHONY: TAGS
## Generate emacs TAGS file
TAGS:
	$(CTAGS) -R -e --language=systemverilog --exclude=boot/* \
		--exclude=freertos/* --exclude=fw/* --exclude=pkg/* \
		--exclude=pulp-runtime/* --exclude=pulp-sdk/* \
		--exclude=sdk-releases/* --exclude=tests/* \
		--exclude=util/* --exclude=install/* --exclude=env/* \
		--exclude=synth/* \
		--exclude=*.patch --exclude=*.md --exclude=*.log \
		--exclude=*.vds --exclude=*.adoc .

.PHONY: help
help: Makefile
	@printf "PULP Platform\n"
	@printf "Available targets\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-15s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
