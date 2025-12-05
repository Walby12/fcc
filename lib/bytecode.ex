defmodule Bytecode do
  def start_let_stmt(file_name, name) do
    File.write!(Path.rootname(file_name) <> ".fbc", "BIND " <> name <> "\n", [:append])
  end

  # helper function that writes the let stmt to a file
  def write_let_stmt(file_name, value) do
    case value do
      v when is_number(value) ->
        File.write!(Path.rootname(file_name) <> ".fbc", "\t" <> to_string(v) <> "\n", [:append])
      _ ->
        File.write!(Path.rootname(file_name) <> ".fbc", "\t" <> value <> "\n", [:append])
    end
  end
end
