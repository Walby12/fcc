RUST_MANIFEST := src/vm/Cargo.toml

all: build_gleam
	@printf "\nBuild complete!\n"

build_script:
	@printf "Script:   [--------------------]   0%%\r"
	@cc -O3 fcc.c -o fcc 2>/dev/null
	@printf "Script:   [####################] 100%%\n"

build_rust: build_script
	@printf "Vm:       [--------------------]   0%%\r"
	@cargo build --release --manifest-path $(RUST_MANIFEST) --quiet 2>/dev/null
	@printf "Vm:       [####################] 100%%\n"

build_gleam: build_rust
	@printf "Compiler: [--------------------]   0%%\r"
	@gleam build --no-print-progress -t erlang 2>/dev/null
	@printf "Compiler: [####################] 100%%"

clean:
	@printf "Cleaning build artifacts...\n"
	@cargo clean --manifest-path $(RUST_MANIFEST)
	@-gleam clean
	@rm -f fcc
	@printf "Clean complete!\n"

.PHONY: all build_script build_rust build_gleam clean
