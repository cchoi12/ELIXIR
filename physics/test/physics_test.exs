defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  describe ".Rocketry" do
    test "escape velocity of earth is correct" do
      #notice how you can pipe directly to IO.inspect? And still get the value returned...
      ev = Physics.Rocketry.escape_velocity(:earth) |> IO.inspect
      assert ev == 11.2 
    end

    test "escape velocity of planet X is correct" do
      planet_x = %{mass: 4.0e22, radius: 6.21e6}
      ev =  planet_x |> Physics.Rocketry.escape_velocity |> IO.inspect
      assert ev == 1.0 
    end

    test "escape velocity only accepts maps" do
      planet_fake = "Fake Planet"
      catch_error(planet_fake |> Physics.Rocketry.escape_velocity |> IO.inspect)
    end
  end

  describe ".Converter" do
    test "rounds to_nearest_tenth correctly" do
      assert 0.8 == 0.75 |> Converter.to_nearest_tenth
    end

    test "converts to km correctly" do
      assert 1 == 1000 |> Converter.to_km
    end

    test "round up only accepts floats" do
      catch_error(24 |> Converter.round_up)
    end

    test "round_up truncs value correctly" do
      assert 1 == 1.35 |> Converter.round_up
    end 
  end
end
