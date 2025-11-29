defmodule Lexer do
  # main lexer function
  def get_tok(src, builder, index) do
    if index >= String.length(src) do
      if builder == "" do
        {:EOF} 
      else
        {map_token(builder), index}
      end
    else
      c = String.at(src, index)
    
      case c do
        " " ->
          t = map_token(builder)
          {t, index + 1}
        "\n" ->
          Utils.update_line()
          get_tok(src, "", index + 1)
        _ -> get_tok(src, builder <> c, index + 1)
      end
    end
  end
  
  # helper function that returns a token type based on the input
  def map_token str do
    case str do
      "let" -> 
        {:LET}
      "=" ->
        {:EQUALS}
      _ ->
        case String.match?(str, ~r/^\p{L}*$/) do
          true -> 
            {:ID, str}
          false -> 
            case Integer.parse(str) do
              {n, ""} -> 
                {:NUMBER, n}
              _ -> 
                Utils.report_error("Undefined char: " <> str)
                System.halt(1)
            end
        end
    end
  end
end
