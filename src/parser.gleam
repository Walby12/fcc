import gleam/io
import gleam/string
import lexer as lex
import source as src_mod

// Function that inits all the processes
pub fn parse_init(src: String) -> #(src_mod.Source, List(String)) {
	let str_ret = string.split(src, "")
	let source = src_mod.insert_split(str_ret)
	#(source, str_ret)
} 

// Main parsers func
// TODO: add more parsing
pub fn parse(tok: Result(lex.Token, lex.Errors), src: src_mod.Source, index: Int) -> Nil {
	case tok {
		Ok(lex.LET) -> {
			let #(t, i) = lex.get_tok(src.v, index, "")
			case t {
				Ok(lex.ID(v)) -> io.println("Var_name: " <> v)
				_ -> lex.error_at("Expected an id but got: " <> tok_to_string(tok), lex.get_counter())
			}
		}
		_ -> io.println("TODO")
	}
}

// Helper function that returns a string based on a token
fn tok_to_string(t: Result(lex.Token, lex.Errors)) -> String {
	case t {
		Ok(lex.ID(v)) -> v
		Ok(lex.EQUALS) -> "="
		Ok(lex.EOF) -> "eof"
		_ -> "TODO"
	}
}
