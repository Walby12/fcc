import gleam/string
import lexer as lex
import source as src_mod
import parser as par

pub fn main() -> Nil {
	lex.start_counter()
	lex.add_counter()
	let src = string.split("let id", "")
	let source_type = src_mod.insert_split(src)

	let source = src_mod.get_source(source_type)
	
	let #(t, i) = lex.get_tok(source, 0, "")
	par.parse(t, source_type, i)
}
