defmodule Fcc do
  def hi do
    x = Lexer.get_tok "hi", "", 0
    case x do
      :EOF -> IO.puts "EOF"
      {:ID, str} -> :io.format "ID(~s)\n", [str]
    end
  end
end
