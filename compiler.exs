time_old = System.monotonic_time()

args = System.argv()

if length(args) == 1 do
  file_name = List.first(args)
  Utils.start_counter()
  
  case File.read(file_name) do
    {:ok, src} ->
      src_trim = String.trim(src)
      IO.puts("\e[34mINFO\e[0m: Lexing and Compiling...")
      File.write!(Path.rootname(file_name) <> ".fbc", "")
      Fcc.compile([], src_trim, 0, file_name)
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
