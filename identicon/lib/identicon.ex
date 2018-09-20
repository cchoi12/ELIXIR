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
    |> build_grid
  end

  @doc """
  Generates grid out of image struct.

  ## Example
      iex> hex = Identicon.hash_input("example")
      iex> Identicon.build_grid(hex) |> IO.inspect
      [[0,1,2,3,4,5]]
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> mirror_row(x) end)
  end

  @doc """
  Copies and appends indexes [0, 1] to the row.

  ## Example
      iex> Identicon.mirror_row([1, 2, 3]) |> IO.inspect
      [1, 2, 3, 2, 1]
  """
  def mirror_row(row) do
    # in [1, 2, 3]
    [first, second | _tail] = row

    # out [1, 2, 3, 2, 1]
    row ++ [second, first]
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
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
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
