defmodule Codegen do
  # helper function that inits the codegen
  def codegen_start(file_name, func_names) do
    File.write!(Path.rootname(file_name) <> ".erl", "-module(" <> Path.rootname(file_name) <> ").\n")
    File.write!(Path.rootname(file_name) <> ".erl", "-export([", [:append])
    codegen_emit_funcs(file_name, func_names, 0)
    codegen_write_funcs(file_name, func_names, 0)
  end
  
  # functions that emit the functions in the export
  def codegen_emit_funcs(file_name, func_names, index) when index == length(func_names) do
    File.write!(Path.rootname(file_name) <> ".erl", "]).\n", [:append])
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
        IO.puts("ERROR: Could not find function arity for #{func_name}.")
        System.halt(1)
    end
  end
  
  # functions that emit the actual functions
  def codegen_write_funcs(_file_name, func_names, index) when index == length(func_names) do
    :ok
  end

  def codegen_write_funcs(file_name, func_names, index) do
    func_name = Enum.at(func_names, index)
    
    case Funcs.get_func(func_name) do
      {v, _} ->
        case v do
          value when is_integer(v) ->
            File.write!(Path.rootname(file_name) <> ".erl", func_name <> "() ->\n\t" <> to_string(value) <> ".\n", [:append])
            codegen_write_funcs(file_name, func_names, index + 1)
          _ ->
            File.write!(Path.rootname(file_name) <> ".erl", func_name <> "() ->\n\t" <> v <> ".\n", [:append])
            codegen_write_funcs(file_name, func_names, index + 1)
        end
      _ ->
        IO.puts("ERROR: Could not find definition for function #{func_name}.")
        System.halt(1)
    end
  end
end
