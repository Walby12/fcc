import gleam/string
import gleam/list

pub type Token {
	ID
	NUMBER
	EOF
}

pub type Lexer {
	Lexer (src: List(String), cur_tok: Token)
}

fn init_lexer(code: String) -> Lexer {
	Lexer(string.split(code, ""), EOF)
}

// Transform list of string to a string
fn to_string(l: List(String)) -> Result(String, Nil) {
	case l {
		[n, ..] -> Ok(n)
		_ -> Error(Nil)
	}
}

// TODO: add more lexing
pub fn get_tok(lex: Lexer, index: Int) ->  String  {
	let s = to_string(list.drop(lex.src, index))
	case s {
		Ok(str) -> str
		Error(_) -> "ERROR: something went very wrong report this bug"
	}
}

// fn lexe(lex: Lexer, str: String) -> Nil {}

// TODO: add a loop to lexer
pub fn main() -> Nil {
	let lexer = init_lexer("Hello world")
	let t = get_tok(lexer, 0)
	echo t
	Nil
}
