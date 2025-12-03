defmodule Codegen do
  def codegen_start(file_name, func_names) do
    File.write!(Path.rootname(file_name) <> ".erl", "-module(" <> file_name <> ").\n")
    File.write!(Path.rootname(file_name) <> ".erl", "-export([", [:append])
    codegen_emit_funcs(file_name, func_names, 0)
  end

  def codegen_emit_funcs(file_name, func_names, index) when index == length(func_names) do
    File.write!(Path.rootname(file_name) <> ".erl", "]).\n", [:append])
    :ok
  end

  def codegen_emit_funcs(file_name, func_names, index) do
    func_name = Enum.at(func_names, index)
    is_last = index == length(func_names) - 1
    separator = if is_last, do: "", else: ","

    case Funcs.get_func(func_name) do
      {_, n} ->
        entry = func_name <> "/" <> Integer.to_string(n) <> separator
        File.write!(Path.rootname(file_name) <> ".erl", entry, [:append])
        codegen_emit_funcs(file_name, func_names, index + 1)
      _ ->
        IO.puts("Warning: Could not find function arity for #{func_name}. Skipping...")
        codegen_emit_funcs(file_name, func_names, index + 1)
    end
  end
end
