defmodule Fcc do
  def compile(src, i) do
    token = Lexer.get_tok src, "", i

    case token do
      :EOF -> 
        IO.puts "EOF!!!"
        {:ok, :ok_lexing}
      {_, next_index } -> compile src, next_index
    end
  end
end
