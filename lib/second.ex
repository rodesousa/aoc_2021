defmodule Second do
  @moduledoc """
  https://adventofcode.com/2021/day/2 
  """
  defstruct position: 0, depth: 0

  @type t :: [position: integer, depth: integer]

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

  def perform(["forward", value], measure),
    do: %Second{measure | position: measure.position + String.to_integer(value)}

  def perform(["down", value], measure),
    do: %Second{measure | depth: measure.depth + String.to_integer(value)}

  def perform(["up", value], measure),
    do: %Second{measure | depth: measure.depth - String.to_integer(value)}
end
