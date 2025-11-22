import gleam/io
import gleam/int
import simplifile as file
import lexer as lex
import source as src_mod

// Main parser func
// TODO: add more parsing
pub fn parse(tok: Result(lex.Token, lex.Errors), src: src_mod.Source, index: Int) -> Nil {
	case tok {
		Ok(lex.LET) -> {
			let #(t, i) = lex.get_tok(src.v, index, "")
			case t {
				Ok(lex.ID(v)) -> {
					let #(t, i) = lex.get_tok(src.v, i, "")
					case t {
						Ok(lex.EQUALS) -> {
							let #(t, i) = lex.get_tok(src.v, i, "")
							case t {
								Ok(lex.NUMBER(n)) -> { 
									let assert Ok(_) = file.append(src_mod.return_name(src), "PUSH " <> int.to_string(n) <> "\nBIND " <> v <> "\n")
									let #(t, i) = lex.get_tok(src.v, i, "") 
									parse(t, src, i) 
								}
								_ -> { lex.error_at("Expected a number but got: " <> tok_to_string(t)) lex.exit(1) }
							}
						}
						_ -> { lex.error_at("Expected = but got: " <> tok_to_string(t)) lex.exit(1) }
					}
				}
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
		Ok(lex.EOF) -> "eof"
		Error(_) -> "Error"
	}
}
