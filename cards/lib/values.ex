defmodule Values do
  @moduledoc """
    Card values and suits
  """

  def values,
    do: [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

  def suits, do: ["Spades", "Clubs", "Hearts", "Diamonds"]
end
