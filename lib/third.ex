defmodule Third do
  @moduledoc """
  https://adventofcode.com/2021/day/3
  """
  @doc """
  Finds:
    - gama rate: most common  bit
    - epsilon rate: least common bit

  Multiply them (decimal)
  """
  @spec part_one(String.t()) :: integer()
  def part_one(pathfilename) do
    gama =
      File.stream!(pathfilename)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, "", trim: true))
      |> Enum.zip()
      |> Stream.map(fn line ->
        line
        |> Tuple.to_list()
        |> Enum.frequencies()
        |> Enum.max_by(fn {_, value} -> value end)
        |> elem(0)
      end)

    epsilon_decimal =
      gama
      |> Enum.map(fn
        "1" -> "0"
        "0" -> "1"
      end)
      |> Enum.join()
      |> String.to_integer(2)

    gama_decimal =
      gama
      |> Enum.join()
      |> String.to_integer(2)

    epsilon_decimal * gama_decimal
  end

  @doc """
  - To find oxygen generator rating, determine the most common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 1 in the position being considered.
  - To find CO2 scrubber rating, determine the least common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 0 in the position being considered.
  """
  def part_two do
  end
end
