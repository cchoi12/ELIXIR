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

  test "build_grid generates a mirrored list" do
    struct = Identicon.hash_input("test")

    assert 25 == Identicon.build_grid(struct).grid |> length
  end

  test "filter_odd_squares filters odd 2 ele tuples" do
    struct = Identicon.main("test")
    filtered_struct = struct |> Identicon.build_grid() |> Identicon.filter_odd_squares()

    assert 10 == filtered_struct.grid |> length
  end
end
