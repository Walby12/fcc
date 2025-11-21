import gleam/string
import gleam/list
import gleam/int
import gleam/io

// function decalred in src/exit_ffi.erl
@external(erlang, "exit_ffi", "do_exit")
pub fn exit(exit_code: Int) -> Nil

// functions declared in src/counter.erl
@external(erlang, "counter", "start_counter")
pub fn start_counter() -> Nil

@external(erlang, "counter", "add_counter")
pub fn add_counter() -> Nil

@external(erlang, "counter", "get_counter")
pub fn get_counter() -> Int

pub type Token {
	ID(value: String)
	NUMBER(value: Int)
	LET
	EQUALS
	OPENPAREN
	CLOSEPAREN
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

// Main lexer function
// TODO: add more lexing
pub fn get_tok(lex: List(String), index: Int, builder: String) ->  #(Result(Token, Errors), Int)  {
	let s = to_string(list.drop(lex, index))
	case s {
		Ok(str) -> case str {
			" " -> {
				let index = index + 1
				#(lexe(lex, index, builder), index)
			}
			"\n" -> {
				add_counter()
				let index = index + 1
				#(lexe(lex, index, builder), index)
			}
			_ -> {
				let builder = string.append(builder, str)
				let index = index + 1
				get_tok(lex, index, builder)
			}
		}
		Error(Nil) -> #(lexe(lex, index, builder), index)
	}
}

// Map a string to a token
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
		"let" -> Ok(LET)
		"/" -> Ok(DIV)
		_ -> { Ok(ID(str)) }
	}
}

// helper func that checks if the id is a char or a normal string
fn is_a_special_symbol(text: String) -> Result(Token, Errors) {

	case string.length(text) {
		1 -> {
			let char = string.first(text)

			case char {
        		Ok("/") -> Ok(DIV)
				Ok("=") -> Ok(EQUALS)
				Ok("(") -> Ok(OPENPAREN)
				Ok(")") -> Ok(CLOSEPAREN)
				Ok("{") -> Ok(OPENCURLY)
				Ok("}") -> Ok(CLOSECURLY)
        		_ -> Error(UNDEF(text))
			}
    	}
    	_ -> {
			lexe_id(text)
    	}
	}
}

// Function that prints the value tied to a token
pub fn print_tok_value(t: Result(Token, Errors)) -> Nil {
	case t {
		Ok(ID(v)) -> io.println("ID: " <> v)
		Ok(NUMBER(n)) -> io.println("NUMBER: " <> int.to_string(n))
		_ -> { io.println("Invalid token passed to print_tok_value") exit(0) }
	}
}

// helper function that reports custom errors
pub fn error_at(msg: String) -> Nil {
	io.println("ERROR: " <> msg)
	io.println("Error at line: " <> int.to_string(get_counter()))
}
