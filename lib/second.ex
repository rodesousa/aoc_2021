defmodule SecondAim do
  defstruct position: 0, depth: 0, aim: 0
end

defmodule Second do
  @moduledoc """
  https://adventofcode.com/2021/day/2 
  """
  defstruct position: 0, depth: 0

  @doc """
  Reads the `pathfilename`
  """
  @spec read_file!(String.t()) :: {:ok, [integer()]} | {:error, any}
  def read_file!(pathfilename) do
    File.read!(pathfilename)
    |> String.split("\n")
    |> Enum.reduce(
      [],
      fn
        "", acc -> acc
        measure, acc -> [String.split(measure, " ") | acc]
      end
    )
    |> Enum.reverse()
  end

  @doc """
  - forward X increases the horizontal position by X units.
  - down X increases the depth by X units.
  - up X decreases the depth by X units.

  Multiply the position and depth
  """
  @spec compute(list) :: integer
  def compute(list) do
    measure =
      Enum.reduce(list, %Second{}, fn command, acc ->
        perform(command, acc)
      end)

    measure.depth * measure.position
  end

  defp perform(["forward", value], measure),
    do: %Second{measure | position: measure.position + String.to_integer(value)}

  defp perform(["down", value], measure),
    do: %Second{measure | depth: measure.depth + String.to_integer(value)}

  defp perform(["up", value], measure),
    do: %Second{measure | depth: measure.depth - String.to_integer(value)}

  @doc """
  - down X increases your aim by X units.
  - up X decreases your aim by X units.
  - forward X does two things:
      It increases your horizontal position by X units.
      It increases your depth by your aim multiplied by X.

  Multiply the position and depth
  """
  @spec compute_aim(list) :: integer
  def compute_aim(list) do
    measure =
      Enum.reduce(list, %SecondAim{}, fn command, acc ->
        perform_aim(command, acc)
      end)

    measure.depth * measure.position
  end

  defp perform_aim(["forward", value], measure) do
    value = String.to_integer(value)

    %SecondAim{
      measure
      | position: measure.position + value,
        depth: measure.depth + measure.aim * value
    }
  end

  defp perform_aim(["down", value], measure) do
    value = String.to_integer(value)

    %SecondAim{
      measure
      | aim: measure.aim + value
    }
  end

  defp perform_aim(["up", value], measure) do
    value = String.to_integer(value)

    %SecondAim{
      measure
      | aim: measure.aim - value
    }
  end
end
