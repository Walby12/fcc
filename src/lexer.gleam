import gleam/string
import gleam/list
import gleam/int

pub type Token {
	ID(value: String)
	NUMBER(value: Int)
	FN
	OPENPAREN
	CLOSEPAREN
	ARROW
	OPENCURLY
	CLOSECURLY
	DIV
	EOF
}

pub type Errors {
	UNDEF(value: String)
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
				Error(Nil) -> case is_a_special_symbol(str) {
					Error(UNDEF(v)) -> Error(UNDEF(v))
					Ok(t) -> Ok(t)
				}
			}
	}
}

// TODO: Find a way to catch errors at lexing part
fn lexe_id(str: String) -> Result(Token, Errors) {
	case str {
		"fn" -> Ok(FN)
		"(" -> Ok(OPENPAREN)
		")" -> Ok(CLOSEPAREN)
		"->" -> Ok(ARROW)
		"{" -> Ok(OPENCURLY)
		"}" -> Ok(CLOSECURLY)
		"/" -> Ok(DIV)
		_ -> { Ok(ID(str)) }
	}
}

// Print the value tied to a token
pub fn print_tok_value(t: Result(Token, Errors)) -> Nil {
	case t {
		Ok(ID(v)) -> { echo v Nil }
		Ok(NUMBER(v)) -> { echo v Nil }
		Ok(EOF) -> { echo "Finished lexing" Nil }
		Ok(FN) -> { echo "fn" Nil }
		Ok(OPENPAREN) -> { echo "open paren" Nil }
		Ok(CLOSEPAREN) -> { echo "close paren" Nil }
		Ok(ARROW) -> { echo "arrow" Nil }
		Ok(OPENCURLY) -> { echo "open curly" Nil }
		Ok(CLOSECURLY) -> { echo "close curly" Nil }
		Ok(DIV) -> { echo "Div" Nil }
		Error(UNDEF(v)) -> { echo v Nil }
	}
}

// helper func that checks if the id is a char or an id 
fn is_a_special_symbol(text: String) -> Result(Token, Errors) {

	case string.length(text) {
		1 -> {
			let char = string.first(text)
      
			case char {
        		Ok("/") -> Ok(DIV)
        		_ -> Error(UNDEF(text))
			}
    	}
    	_ -> {
			lexe_id(text)
    	}
	}
}
