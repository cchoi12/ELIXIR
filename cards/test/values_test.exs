defmodule ValuesTest do
  use ExUnit.Case
  doctest Values

  test "Returns 13 values" do
    assert 13 == Values.values() |> length
  end

  test "Returns 4 suits" do
    assert 4 == Values.suits() |> length
  end
end
