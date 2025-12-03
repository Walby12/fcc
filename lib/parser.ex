defmodule Parser do
  # main parser function
  def parse(toks, index, file_name, funcs) do
    t = Enum.at(toks, index)

    case t do
      {:LET} -> 
        new_index = index + 1
        {new_index, new_funcs} = parse_let_stmt(toks, new_index, file_name, funcs)
        parse(toks, new_index, file_name, new_funcs)
      {:EOF} ->
        IO.puts "\e[34mINFO\e[0m: Finished producing bytecode."
        funcs
    end
  end
  
  # helper function for parsing let stmt
  def parse_let_stmt(toks, index, file_name, funcs) do
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
                Funcs.new_func(n, v)
                ByteCode.write_let_stmt(file_name, n, v)
                {new_index, funcs ++ [n]}
              _ ->
                Utils.report_error("Expected an integer after = but got: " <> Utils.tok_to_string(t), file_name)
                System.halt(1)
            end
          _ ->
            Utils.report_error("Expected = after the identifier but got: " <> Utils.tok_to_string(t), file_name)
            System.halt(1)
        end
      _ ->
        Utils.report_error("Expected a name after let but got: " <> Utils.tok_to_string(t), file_name)
        System.halt(1)
    end
  end
end
