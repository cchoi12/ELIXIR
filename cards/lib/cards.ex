defmodule Cards do
  import Values

  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings listing a deck of playing cards

    ## Examples
        iex> deck = Cards.create_deck |> length
        iex> deck
        52
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> shuffle
    |> deal(5)
  end

  def create_deck do
    for suit <- Values.suits(), value <- Values.values(), uniq: true do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a specific card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` arg indicates how many careds should be
  in the hand.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def delete_deck(filename) do
    case File.rm(filename) do
      :ok -> "File successfully deleted"
      {:error, _} -> "That file does not exist"
    end
  end
end
