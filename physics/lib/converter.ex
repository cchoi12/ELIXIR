defmodule Converter do

  def to_nearest_tenth(val) do
    round_to(val, 1)
  end

  def to_km(val) do
    val / 1000
  end

  def to_meters(val) do
    val * 1000
  end

  def to_light_seconds({unit, val}, precision: precision) do
    case unit do
      :miles  -> from_miles(val)
      :meters -> from_meters(val)
      :feet   -> from_feet(val)
      :inches -> from_inches(val)
    end |> round_to(precision)
  end

  def seconds_to_hours(val) do
    (val / 60)
      |> minutes_to_hours
  end

  def minutes_to_hours(val) do
    (val / 60)
  end

  defp from_miles(val), do: val * 5.36819e-6
  defp from_meters(val), do: val * 3.335638620368e-9
  defp from_feet(val), do: val * 1.016702651488166404e-9
  defp from_inches(val), do: val * 8.472522095734715723e-11

  defp round_to(val, precision) when is_float(val) do
    Float.round(val, precision)
  end

end

defmodule ConverterTwo do

  def to_nearest_tenth(val) do
    round_to(val, 1)
  end

  def to_km(val) do
    val / 1000
  end

  def to_meters(val) do
    val * 1000
  end

  def to_light_seconds(arg), do: to_light_seconds(arg, precision: 5)

  def to_light_seconds({unit, val}, precision: precision) do
    light_seconds = case unit do
      :miles  -> from_miles(val)
      :meters -> from_meters(val)
      :feet   -> from_feet(val)
      :inches -> from_inches(val)
    end
    light_seconds |> round_to(precision)
  end

  defp from_miles(val), do: val * 5.36819e-6
  defp from_meters(val), do: val * 3.335638620368e-9
  defp from_feet(val), do: val * 1.016702651488166404e-9
  defp from_inches(val), do: val * 8.472522095734715723e-11


  defp round_to(val, precision) when is_float(val) do
    Float.round(val, precision)
  end

end


