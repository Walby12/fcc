defmodule Lexer do
  # main lexer function
  def get_tok(src, builder, index, file_name) do
    if index >= String.length(src) do
      if builder == "" do
        {:EOF} 
      else
        {map_token(builder, file_name), index}
      end
    else
      c = String.at(src, index)
      
      if builder != "" and (c == " " or c == "\n" or c == "\r" or c == "=") do
        t = map_token(builder, file_name)
        {t, index}
      else
        case c do
          " " ->
            get_tok(src, builder, index + 1, file_name)
          "\n" ->
            Utils.update_line()
            get_tok(src, builder, index + 1, file_name)
          "\r" ->
            get_tok(src, builder, index + 1, file_name)
          "=" ->
            {map_token(c, file_name), index + 1}
          _ -> 
            get_tok(src, builder <> c, index + 1, file_name)
        end
      end
    end
  end
  
  # helper function that maps a string to a token
  def map_token str, file_name do
    if str == "", do: nil 

    case str do
      "let" -> 
        {:LET}
      "=" ->
        {:EQUALS}
      _ ->
        case String.match?(str, ~r/^\p{L}[\p{L}_0-9]*$/) do
          true ->
            {:ID, str}
          false -> 
            case Integer.parse(str) do
              {n, ""} -> 
                {:NUMBER, n}
              _ -> 
                Utils.report_error("Undefined token: " <> str, file_name)
                System.halt(1)
            end
        end
    end
  end
end
