defmodule Calcs do

  def square_root(val), do: :math.sqrt(val)
  def squared(val), do: val * val
  def cubed(val), do: val * val * val
  def n_root(val, n), do: val |> :math.pow(n)

end
