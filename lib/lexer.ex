defmodule Lexer do
  @tokens [:ID, :LET, :EOF]
  
  # main lexer function
  def get_tok(src, builder, index) do
    if index >= String.length(src) do
      if builder == "" do
        :EOF 
      else
        {map_token(builder), index}
      end
    else
      c = String.at(src, index)
    
      case c do
        " " ->
          t = map_token(builder)
          {t, index + 1}

        _ -> get_tok(src, builder <> c, index + 1)
      end
    end
  end

  # helper function that returns a token type based on the input
  def map_token str do
    case str do
      "let" -> 
        IO.puts "LET"
        :LET
      _ -> 
        :io.format "ID(~s)\n", [str]
        :ID
    end
  end
end
