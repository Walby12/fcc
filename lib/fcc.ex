defmodule Fcc do
  # main compiler function 
  def compile(tokens, src, i, file_name) do
    token = Lexer.get_tok src, "", i, file_name

    case token do
      {:EOF} -> 
        toks = tokens ++ [token]
        IO.puts("\e[34mINFO\e[0m: Parsing and building AST...")
        Parser.parse(toks, 0, file_name)
      {t, next_index } -> 
        new_tokens = tokens ++ [t]
        compile new_tokens, src, next_index, file_name
    end
  end
end
