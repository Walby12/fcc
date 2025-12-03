import GVA

defmodule Utils do
  @doc """
  This all all helper functions that can be called in all of the compilation steps
  """
  
  @red "\e[31m"
  @yellow "\e[33m"
  @reset "\e[0m"
  @bold "\e[1m"

  def colorize(text, code) do
    "#{code}#{text}#{@reset}"
  end

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

  def report_error(str, file_name) do
    :io.format (colorize("#{@yellow}"<> file_name <> " line: " <> Integer.to_string(get_line()) <> "#{@reset}" <> " #{@red}ERROR#{@reset}: " <> str <> "\n", @bold))
  end

  def tok_to_string(tok) do
    case tok do
      {:ID, n} -> "identifier(" <> n <> ")"
      {:LET} -> "let keyword"
      {:EOF} -> "end of file"
      {:NUMBER, n} -> "integer(" <> Integer.to_string(n) <> ")"
      {:EQUALS} -> "="
    end
  end

  def check_for_start(func_names, index) when index == length(func_names) do
    :err
  end

  def check_for_start(func_names, index) do
    func_name = Enum.at(func_names, index)

    case func_name do
      "start" -> :ok
      _ -> check_for_start(func_names, index + 1)
    end
  end
end
