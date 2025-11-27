defmodule Fcc do
  # main compile function 
  def compile(tokens, src, i) do
    token = Lexer.get_tok src, "", i

    case token do
      :EOF -> 
        IO.puts "EOF!!!"
        {:ok, :ok_lexing}
      {t, next_index } -> 
        new_tokens = tokens ++ [t]
        compile new_tokens, src, next_index
    end
  end
end
