args = System.argv()

if length(args) == 1 do
  file_name = List.first(args)
  Utils.start_counter()
  Fcc.compile([], "let name = 12", 0, file_name)
else
  IO.puts "ERROR: expected one argument\n"
  IO.puts "USAGE: fcc <file_name>\n"
end
