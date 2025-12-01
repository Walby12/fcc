defmodule ByteCode do
  # helper function that writes the let stmt to a file
  def write_let_stmt(file_name, name, value) do
    cont = "BIND " <> name <> " " <> Integer.to_string(value) <> "\n"
    File.write!(Path.rootname(file_name) <> ".fbc", cont, [:append])
  end
end
