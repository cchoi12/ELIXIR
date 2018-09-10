defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates deck successfully" do
    deck = Cards.create_deck() |> length |> IO.inspect()
    assert 52 == deck
  end

  test "shuffle cards randomizes successfully" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end

  test "contains detects match successfully" do
    deck = ["Ace", "Two", "Three"]
    assert Cards.contains?(deck, "Ace") == true
  end

  test "saves, loads, and deletes deck successfully" do
    deck = Cards.create_deck()
    Cards.save(deck, "test_file")
    assert Cards.load("test_file") == deck
    assert Cards.delete_deck("test_file") == "File successfully deleted"
  end
end
