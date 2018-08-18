defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "greets the world" do
    assert Physics.hello() == :world
  end

  test "the truth" do
    assert 1 + 1 == 2
  end
end
