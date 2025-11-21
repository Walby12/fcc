import gleam/io
import gleam/string
import gleam/int
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
				Ok(lex.ID(_)) -> {
					let #(t, i) = lex.get_tok(src.v, i, "")
					case t {
						Ok(lex.EQUALS) -> {
							let #(t, i) = lex.get_tok(src.v, i, "")
							case t {
								Ok(lex.NUMBER(n)) -> { 
									io.println("var value: " <> int.to_string(n))
									let #(t, i) = lex.get_tok(src.v, i, "") 
									parse(t, src, i) }
								_ -> { lex.error_at("Expected a number but got: " <> tok_to_string(t)) lex.exit(1) }
							}
						}
						_ -> { lex.error_at("Expected = but got: " <> tok_to_string(t)) lex.exit(1) }
					}
				}
				Error(lex.UNDEF(text)) -> io.println("Let id must be at least 2 char long, got: " <> text) 
				_ -> { lex.error_at("Expected an identifier but got: " <> tok_to_string(t)) lex.exit(1) } 
			}
		}
		Ok(lex.EOF) -> io.println("Finished parsing")
		_ -> io.println("TODO")
	}
}

// Helper function that returns a string based on a token
fn tok_to_string(t: Result(lex.Token, lex.Errors)) -> String {
	case t {
		Ok(lex.ID(_)) -> "id"
		Ok(lex.NUMBER(_)) -> "number"
		Ok(lex.EQUALS) -> "="
		Ok(lex.LET) -> "let"
		Ok(lex.OPENPAREN) -> "("
		Ok(lex.CLOSEPAREN) -> ")"
		Ok(lex.OPENCURLY) -> "{"
		Ok(lex.CLOSECURLY) -> "}"
		Ok(lex.DIV) -> "/"
		Error(_) -> "Error"
		Ok(lex.EOF) -> "eof"
	}
}
