defmodule Fcc do
  def main(args) do
    time_old = System.monotonic_time()

    if length(args) == 1 do
      file_name = List.first(args)
      Utils.start_counter()
      
      case File.read(file_name) do
        {:ok, src} ->
          src_trim = String.trim(src)
          IO.puts("\e[34mINFO\e[0m: Lexing and Compiling...")
          File.write!(Path.rootname(file_name) <> ".fbc", "")
          Fcc.compile([], src_trim, 0, file_name)

          IO.puts("\e[34mINFO\e[0m: Producing erlang files...")
          Codegen.codegen_start(file_name)
        {:error, reason} ->
          IO.inspect({:error, reason}, label: "Failed to read file")
      end
    else
      IO.puts "\e[31mERROR\e[0m: expected one argument"
      IO.puts "\e[33mUSAGE\e[0m: fcc <file_name>"
    end

    time_new = System.monotonic_time()
    duration_ns = time_new - time_old
    duration_s = duration_ns / 1_000_000_000

    :io.format("\e[32mCompilation finished\e[0m in ~.2f seconds\n", [duration_s])
  end

  # main compiler function 
  def compile(tokens, src, i, file_name) do
    token = Lexer.get_tok src, "", i, file_name

    case token do
      {:EOF} -> 
        toks = tokens ++ [token]
        IO.puts("\e[34mINFO\e[0m: Parsing and building AST...")
        Parser.parse(toks, 0, file_name)
      {t, next_index } -> 
        new_tokens = tokens ++ [t]
        compile new_tokens, src, next_index, file_name
    end
  end
end
