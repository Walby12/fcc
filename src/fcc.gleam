import gleam/string
import gleam/io
import simplifile as file
import argv
import lexer as lex
import source as src_mod
import parser as par

// Helper function that parse args
fn parse_args() -> String {
	case argv.load().arguments {
		[file_path] -> file_path
		_ -> { io.println("ERROR: Passed the wrong number of args") io.println("USAGE: ./fcc <file_path>") lex.exit(0) ""}
	}
}

pub fn main() -> Nil {
	lex.start_counter()
	lex.add_counter()
	let file_name = parse_args()
	let conts = file.read(from: file_name)
	
	let src = case conts {
		Ok(v) -> string.split(v, "")
		Error(_) -> { io.println("ERROR: could not read from file: " <> file_name) lex.exit(1) [""]}
	}
	let source_type = src_mod.start_comp(src, string.replace(file_name, ".fcc", ".fbc"))
	let assert Ok(_) = "" |> file.write(to: src_mod.return_name(source_type))

	let source = src_mod.get_source(source_type)
	
	let #(t, i) = lex.get_tok(source, 0, "")
	par.parse(t, source_type, i)
}
