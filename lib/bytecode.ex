defmodule ByteCode do
  # helper function that writes the let stmt to a file
  def write_let_stmt(file_name, name, value) do
    case value do
      v when is_number(value) ->
        cont = "BIND " <> name <> " " <> Integer.to_string(v) <> "\n"
        File.write!(Path.rootname(file_name) <> ".fbc", cont, [:append])
      _ ->
        cont = "BIND " <> name <> " " <> value <> "\n"
        File.write!(Path.rootname(file_name) <> ".fbc", cont, [:append])
    end
  end
end
