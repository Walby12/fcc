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
end
