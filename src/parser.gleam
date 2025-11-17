import lexer as lex

pub fn parse(tok: Result(lex.Token, lex.Errors)) -> Nil {
	case tok {
		Ok(lex.FN) -> {
			Nil	
		}
		_ -> Nil
	}
}
