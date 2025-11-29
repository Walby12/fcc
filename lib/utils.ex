import GVA

defmodule Utils do
  @doc """
  This all all helper functions that can be called in all of the compilation steps
  """
  def start_counter do
    GVA.gnew(:lines)
    GVA.gput(:lines, :l, 1)
  end

  def update_line() do
    GVA.gget_and_update(:lines, :l, fn (x) -> x + 1 end)
  end

  def get_line() do
    GVA.gget(:lines, :l)
  end

  def report_error(str) do
    :io.format "ERROR: " <> str <> "\n"
    :io.format "Error at line: ~w\n", [get_line()]
  end

  def tok_to_string(tok) do
    case tok do
      {:ID, n} -> "identifier(" <> n <> ")"
      {:LET, _} -> "let keyword"
      {:EOF} -> "end of file"
      {:NUMBER, n} -> "integer(" <> Integer.to_string(n) <> ")"
      {:EQUALS} -> "="
    end
  end
end
