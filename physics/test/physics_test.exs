defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  describe ".Rocketry" do
    test "escape velocity of earth is correct" do
      ev = Physics.Rocketry.escape_velocity(:earth) |> IO.inspect
      assert ev == 11.2
    end

    test "escape velocity of mars is correct" do
      ev = Physics.Rocketry.escape_velocity(:mars) |> IO.inspect
      assert ev == 5.0
    end

    test "escape velocity of the moon is correct" do
      ev = Physics.Rocketry.escape_velocity(:moon) |> IO.inspect
      assert ev == 2.4
    end

    test "escape velocity of planet X is correct" do
      planet_xyz = %{mass: 4.0e22, radius: 6.21e6}
      ev =  planet_xyz |> Physics.Rocketry.escape_velocity |> IO.inspect
      assert ev == 0.9
    end

    test "escape velocity only accepts maps" do
      planet_fake = "Fake Planet"
      catch_error(planet_fake |> Physics.Rocketry.escape_velocity |> IO.inspect)
    end

    test "Orbital acceleration for earth at 100km" do
      orbital_acc = Physics.Rocketry.orbital_acceleration(100)
      assert orbital_acc == 9.515619587729839
    end

    test "Orbital term for 100km above earth" do
      term = Physics.Rocketry.orbital_term(100) |> IO.inspect
      assert (term > 4) && (term < 5) #crap fix this!
    end
  end

  describe ".Converter" do
    test "light seconds converts correctly" do
      light_seconds = Converter.to_light_seconds({:miles, 1000}, precision: 5) |> IO.inspect
      assert light_seconds == 0.00537
    end

    test "rounds to_nearest_tenth correctly" do
      assert 0.8 == 0.75 |> Converter.to_nearest_tenth
    end

    test "converts to km correctly" do
      assert 1 == 1000 |> Converter.to_km
    end

    test "converts to meters correctly" do
      assert 1000 == 1 |> Converter.to_meters
    end

    test "converts seconds to hours correctly" do
      assert 2 == 7200 |> Converter.seconds_to_hours
    end
  end

  describe ".Calcs" do
    test "calculates square root correctly" do
      assert 3 == 9 |> Calcs.square_root
    end

    test "calculates squared value correctly" do
      assert 4 == 2 |> Calcs.squared
    end

    test "calculates cubed value correctly" do
      assert 8 == 2 |> Calcs.cubed
    end
  end
end

