all: build_gleam

build_main:
	@echo [INFO] CMD: mkdir fcc/
	@echo [INFO] CMD: cc -O3 fcc.c -o bin/fcc
	@mkdir fcc/
	@cc -O3 fcc.c -o fcc/fcc

build_vm: build_main
	@cd src/vm && ./nob

build_gleam: build_vm
	@echo [INFO] CMD: gleam build --no-print-progress -t erlang
	@gleam build --no-print-progress -t erlang

clean:
	@gleam clean
	@rm -rf src/vm/bin
	@rm -rf fcc/
