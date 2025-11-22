import gleam/string
import simplifile as file
import lexer as lex
import source as src_mod
import parser as par

pub fn main() -> Nil {
	lex.start_counter()
	lex.add_counter()
	let src = string.split("let id = 12 let pp = 100003", "")
	let source_type = src_mod.start_comp(src, "test.fbc")
	let assert Ok(_) = "" |> file.write(to: src_mod.return_name(source_type))

	let source = src_mod.get_source(source_type)
	
	let #(t, i) = lex.get_tok(source, 0, "")
	par.parse(t, source_type, i)
}
