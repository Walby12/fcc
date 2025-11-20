import gleam/string
import lexer as lex
import source as sorc

pub fn main() -> Nil {
	lex.start_counter()
	lex.add_counter()
	let src = string.split("-> /", "")
	let source_type = sorc.insert_split(src)

	let source = sorc.get_source(source_type)
	echo source

	let #(t, i) = lex.get_tok(source, 0, "")
	lex.print_tok_value(t)
	
	let #(t, i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)

	let #(t, i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)

	let #(t, _i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)
}
