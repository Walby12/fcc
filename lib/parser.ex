defmodule Parser do
  # main parser function
  def parse(toks, index, file_name) do
    t = Enum.at(toks, index)

    case t do
      {:LET} -> 
        new_index = index + 1
        new_index = parse_let_stmt(toks, new_index, file_name)
        parse(toks, new_index, file_name)
      {:EOF} ->
        IO.puts "EOF!!!"
    end
  end
  
  # helper function for parsing let stmt
  def parse_let_stmt(toks, index, file_name) do
    t = Enum.at(toks, index)

    case t do
      {:ID, n} ->
        new_index = index + 1
        t = Enum.at(toks, new_index)
        
        case t do
          {:EQUALS} -> 
            new_index = new_index + 1
            t = Enum.at(toks, new_index)
            
            case t do
              {:NUMBER, v} ->
                new_index = new_index + 1
                :io.format "let stmt name: ~s value: ~w\n", [n, v]
                ByteCode.write_let_stmt(file_name, n, v)
                new_index
              _ ->
                Utils.report_error("Expected an integer after the = but got: " <> Utils.tok_to_string(t))
                System.halt(1)
            end
          _ ->
            Utils.report_error("Expected = after the identifier but got: " <> Utils.tok_to_string(t))
            System.halt(1)
        end
      _ ->
        Utils.report_error("Expected a name after let but got: " <> Utils.tok_to_string(t))
        System.halt(1)
    end
  end
end
