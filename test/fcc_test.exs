defmodule FccTest do
  use ExUnit.Case
  doctest Fcc

  test "greets the world" do
    assert Fcc.hello() == :world
  end
end
