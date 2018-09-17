defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash input returns a list of 16 numbers" do
    struct = Identicon.hash_input("test")

    assert %Identicon.Image{
             hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
           } == struct
  end

  test "pick_color selects first three elements in list" do
    struct = Identicon.hash_input("test")

    assert {9, 143, 107} == Identicon.pick_color(struct).color
  end
end
