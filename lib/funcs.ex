import GVA

defmodule Funcs do
  def func_start do
    GVA.gnew(:funcs)
  end

  def new_func(name, value) do
    GVA.gput(:funcs, name, {value, 0})
  end

  def get_func(name) do
    GVA.gget(:funcs, name)
  end
  
  def check_for_func(funcs, _name, index) when index == length(funcs) do
    nil
  end

  def check_for_func(funcs, name, index) do
    func_name = Enum.at(funcs, index)

    if func_name == name do
      :ok
    else
      check_for_func(funcs, name, index + 1)
    end
  end
end
