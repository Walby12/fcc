defmodule Vm do
  def write_let_stmt(file_name, name, value) do
    cont = "PUSH " <> Integer.to_string(value) <> "\nBIND " <> name
    File.write!(file_name,cont)
  end
end
