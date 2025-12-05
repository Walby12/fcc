defmodule Parser do
  # main parser function
  def parse(toks, index, file_name, funcs) do
    t = Enum.at(toks, index)
    
    case t do
      {:LET} -> 
        index_after_let = index + 1
        {final_index, new_funcs} = parse_let_stmt(toks, index_after_let, file_name, funcs)
        parse(toks, final_index, file_name, new_funcs)
      {:EOF} ->
        IO.puts "\e[34mINFO\e[0m: Finished producing bytecode."
        funcs
      _ ->
        if t == nil do
            funcs
        else
            Utils.report_error("Expected LET or EOF but got: " <> Utils.tok_to_string(t), file_name)
            System.halt(1)
        end
    end
  end
  
  def parse_let_stmt(toks, index, file_name, funcs) do
    t = Enum.at(toks, index)

    case t do
      {:ID, n} ->
        index_after_id = index + 1
        t_equals = Enum.at(toks, index_after_id)
        
        case t_equals do
          {:EQUALS} ->
            index_after_equals = index_after_id + 1
            Bytecode.start_let_stmt(file_name, n) 
            parse_stmt(toks, index_after_equals, file_name, funcs, n)
          _ ->
            Utils.report_error("Expected = after the identifier but got: " <> Utils.tok_to_string(t_equals), file_name)
            System.halt(1)
        end
      _ ->
        Utils.report_error("Expected a name after let but got: " <> Utils.tok_to_string(t), file_name)
        System.halt(1)
    end
  end

  def parse_stmt(toks, index, file_name, funcs, let_id) do
    t = Enum.at(toks, index)
    
    case t do
      {:NUMBER, v} ->
        new_index = index + 1
        Bytecode.write_let_stmt(file_name, v)
        parse_stmt(toks, new_index, file_name, funcs, let_id)
      {:ID, n} ->
        new_index = index + 1
        Bytecode.write_let_stmt(file_name, n)
        parse_stmt(toks, new_index, file_name, funcs, let_id)
      _ ->
        {_, final_value} = Enum.at(toks, index - 1)
        
        if is_atom(final_value) do
          {_, final_value} = Enum.at(toks, index - 1)
          Funcs.new_func(let_id, final_value)
        else
          Funcs.new_func(let_id, final_value)
        end
        {index, funcs ++ [let_id]}
    end
  end
end
