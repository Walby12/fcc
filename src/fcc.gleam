import gleam/string
import gleam/list
import gleam/int

pub type Token {
	ID(value: String)
	NUMBER(value: Int)
	EOF
}

pub type Errors {
	UNDEF
}

// Transform list of string to a string
fn to_string(l: List(String)) -> Result(String, Nil) {
	case l {
		[n, ..] -> Ok(n)
		[] -> Error(Nil)
	}
}

// TODO: add more lexing
pub fn get_tok(lex: List(String), index: Int, builder: String) ->  #(Result(Token, Errors), Int)  {
	let s = to_string(list.drop(lex, index))
	case s {
		Ok(str) -> case str {
			" " -> {
				let index = index + 1
				#(lexe(lex, index, builder), index)
			}
			_ -> {
				let builder = string.append(builder, str)
				let index = index + 1
				get_tok(lex, index, builder)
			}
		}
		Error(_) -> #(lexe(lex, index, builder), index)
	}
}

// Map a string to a token
// TODO: add more cases
fn lexe(lex: List(String), index: Int, str: String) -> Result(Token, Errors) {
	let l = list.length(lex)
	case str {
		"" if index == l -> Ok(EOF)
		_ ->  
			case int.parse(str) {
				Ok(n) -> Ok(NUMBER(n))
				Error(Nil) -> Ok(ID(str))
			}
	}
}

// Print the value tied to a token
fn print_tok_value(t: Result(Token, Errors)) -> Nil {
	case t {
		Ok(ID(v)) -> { echo v Nil }
		Ok(NUMBER(v)) -> { echo v Nil }
		Ok(EOF) -> { echo "Finished lexing" Nil }
		Error(_) -> { echo "ERROR" Nil }
	}
}

// Get the value tied to a token
pub fn get_tok_value(t: #(Result(Token, Errors), Int)) -> Result(Token, Errors) {
	let #(tok, _) = t
	tok
}

// TODO: add a loop to lexer
pub fn main() -> Nil {
	let source = string.split("12 / ->", "")

	let #(t, i) = get_tok(source, 0, "")
	print_tok_value(t)
	
	let #(t, i) = get_tok(source, i, "")
	print_tok_value(t)

	let #(t, _i) = get_tok(source, i, "")
	print_tok_value(t)
}
