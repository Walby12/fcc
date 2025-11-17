import gleam/string
import lexer as lex

pub fn main() -> Nil {
	let source = string.split("12 * ->", "")

	let #(t, i) = lex.get_tok(source, 0, "")
	lex.print_tok_value(t)
	
	let #(t, i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)

	let #(t, i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)

	let #(t, _i) = lex.get_tok(source, i, "")
	lex.print_tok_value(t)
}
