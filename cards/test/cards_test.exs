defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates deck successfully" do
    deck = Cards.create_deck() |> length |> IO.inspect()
    assert 52 == deck
  end

  test "shuffle cards randomizes" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end

  test "contains detects match successfully" do
    deck = ["Ace", "Two", "Three"]
    assert Cards.contains?(deck, "Ace") == true
  end
end
