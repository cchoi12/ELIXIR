defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Main function that takes input string and transforms into identicon.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  @doc """
  Builds tuple pairs for plots on the image builder

  ## Example
      iex> filtered_grid = Identicon.hash_input("test") |> Identicon.build_grid |> Identicon.filter_odd_squares
      iex> filtered_grid |> Identiconbuild_pixel_map
  %Identicon.Image{color: {9, 143, 107}, grid: [{70, 6}, {70, 8}, {202, 12}, {222, 15}, {78, 16}, {78, 18}, {222, 19}, {38, 20}, {180, 22}, {38, 24}],
  hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246],
  pixel_map: [{{50, 50}, {100, 100}}, {{150, 50}, {200, 100}}, {{100, 100}, {150, 150}}, {{0, 150}, {50, 200}}, {{50, 150}, {100, 200}}, {{150, 150}, {200, 200}}, {{200, 150}, {250, 200}}, {{0, 200}, {50, 250}}, {{100, 200}, {150, 250}}, {{200, 200}, {250, 250}}]}

  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        veritical = div(index, 5) * 50

        top_left = {horizontal, veritical}
        bottom_right = {horizontal + 50, veritical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Filters out all odd element tuples from list.

  ## Example
      iex> grid = Identicon.hash_input("test") |> Identicon.build_grid
      iex> filtered_grid = Identicon.filter_odd_squares(grid)
      iex> filtered_grid
      %Identicon.Image{
      color: nil,
      grid: [{70, 6}, {70, 8}, {202, 12}, {222, 15}, {78, 16}, {78, 18}, {222, 19}, {38, 20}, {180, 22}, {38, 24}],
        hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]}
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Generates grid out of image struct.

  ## Example
      iex> hex = Identicon.hash_input("test")
      iex> grid = Identicon.build_grid(hex)
      iex> grid
      %Identicon.Image{
      color: nil,
      grid: [{9, 0}, {143, 1}, {107, 2}, {143, 3}, {9, 4}, {205, 5}, {70, 6}, {33, 7}, {70, 8}, {205, 9}, {211, 10}, {115, 11}, {202, 12}, {115, 13}, {211, 14}, {222, 15}, {78, 16}, {131, 17}, {78, 18}, {222, 19}, {38, 20}, {39, 21}, {180, 22}, {39, 23}, {38, 24}],
      hex: [9, 143, 107, 205, 70, 33, 211,
       115, 202, 222, 78, 131, 38, 39, 180,
       246]
      }
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
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
      iex> hash = Identicon.hash_input("example")
      iex> color_hash = hash |> Identicon.pick_color
      iex> color_hash
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
