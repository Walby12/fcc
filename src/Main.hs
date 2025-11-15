data Token = ID | NUMBER | EOF deriving (Show)
data Lexer = Lexer { src :: String, cur_tok :: Token } deriving (Show)

lexer_init :: String -> Lexer
lexer_init src = 
	Lexer { src = src, cur_tok = EOF }

-- Main func that return a token
-- TODO: Add some kind of progression
get_tok :: Lexer -> ( String, Maybe Token )
get_tok lex = parse (src lex) 1

-- Helper function for get_tok that returns a tuple
-- TODO: pattern match for the Maybe token
parse :: String -> Int -> ( String, Maybe Token )
parse src i = do
	(str, tok) where
		str = take i src 
		tok = return_tok ( take i src )

-- Helper function for parse that return a Maybe token based on the input
-- TODO: add more functionality
return_tok :: String -> Maybe Token 
return_tok str
	| str == " " = Nothing
	| otherwise = Just ID

-- Main function
main :: IO()
main = do
	let lexer = lexer_init " h" 
	
	let ( c, tok ) = get_tok lexer in do
		putStrLn ( c )
		putStrLn ( show tok )
