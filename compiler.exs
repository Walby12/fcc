args = System.argv()

if length(args) == 1 do
  file_name = List.first(args)
  Utils.start_counter()
  case File.read(file_name) do
    {:ok, src} ->
      src_trim = String.trim(src)
      IO.puts("\e[34mINFO\e[0m: Lexing...")
      File.write!(Path.rootname(file_name) <> ".fbc", "")
      Fcc.compile([], src_trim, 0, file_name)
    {:error, reason} ->
      IO.inspect({:error, reason}, label: "Failed to read file")
  end
else
  IO.puts "ERROR: expected one argument"
  IO.puts "USAGE: fcc <file_name>"
end
