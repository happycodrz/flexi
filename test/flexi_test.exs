defmodule FlexiTest do
  use ExUnit.Case
  doctest Flexi

  test "greets the world" do
    assert Flexi.hello() == :world
  end
end
