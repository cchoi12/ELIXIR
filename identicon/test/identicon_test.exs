defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash input returns a list of 16 numbers" do
    struct = Identicon.hash_input("test")

    assert 16 == struct.hex |> length
  end

  test "pick_color selects first three elements in list" do
    struct = Identicon.hash_input("test")

    assert {9, 143, 107} == Identicon.pick_color(struct).color
  end

  test "mirrow_row will mirrow indexes [0, 1] and append them to the list" do
    assert [0, 1, 2, 1, 0] == Identicon.mirror_row([0, 1, 2])
  end

  test "build_graph generates lists in a list" do
    Identicon.build_graph(Identicon.hash_input("test"))
  end
end
