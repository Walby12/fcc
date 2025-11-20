import lexer as lex
import fcc

pub fn parse(tok: Result(lex.Token, lex.Errors)) -> Nil {
	case tok {
		Ok(lex.LET) -> {
			Nil
			// let #(t, i) = lex.get_tok(fcc.source, i, "")
		}
		_ -> Nil
	}
}
