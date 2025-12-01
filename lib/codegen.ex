defmodule Codegen do
  def codegen_start(file_name) do
    File.write!(Path.rootname(file_name) <> ".erl", "-module(" <> file_name <> ").\n")
  end
end
