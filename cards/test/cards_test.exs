defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates deck successfully" do
    assert ["Ace", "Two", "Three"] == Cards.create_deck()
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
