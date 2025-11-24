defmodule Lexer do
  @tokens [:ID, :EOF]

  def get_tok(src, _builder, _index) do
    case src do
      "" -> :EOF
      _ -> 
        {:ID, src}
    end
  end
end
