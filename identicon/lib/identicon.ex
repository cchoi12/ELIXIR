defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  @doc """
  Takes first three values from hash_input and assigns to color of input.

  ## Example
      iex> hash = Identicon.hash_input("example") |> Identicon.pick_color
      iex> hash
      %Identicon.Image{
      color: {26, 121, 164},
      hex: [26, 121, 164, 214, 13, 230, 113, 142, 142, 91, 50, 110, 51, 138, 229, 51]
      }
  """
  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image

    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Turns input into a hash and then to a list of 15 numbers.

  ## Example
      iex> hash = Identicon.hash_input("example")
      iex> hash
      %Identicon.Image{
      color: nil,
      hex: [26, 121, 164, 214, 13, 230, 113, 142, 142, 91, 50, 110, 51, 138, 229, 51]
      }
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
