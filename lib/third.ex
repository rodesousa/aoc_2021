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

  def part_two(pathfilename) do
    list =
      File.stream!(pathfilename)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, "", trim: true))

    o2(list, 0) * co2(list, 0)
  end

  def o2([one], _), do: one |> Enum.join() |> String.to_integer(2)

  def o2(list, i) do
    bit =
      list
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> then(&Enum.at(&1, i))
      |> Enum.frequencies()
      |> then(fn %{"0" => a, "1" => b} ->
        cond do
          a > b -> "0"
          true -> "1"
        end
      end)

    new_list =
      list
      |> Enum.filter(&(Enum.at(&1, i) == bit))

    o2(new_list, i + 1)
  end

  def co2([one], _), do: one |> Enum.join() |> String.to_integer(2)

  def co2(list, i) do
    bit =
      list
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> then(&Enum.at(&1, i))
      |> Enum.frequencies()
      |> then(fn %{"0" => a, "1" => b} ->
        cond do
          a > b -> "1"
          true -> "0"
        end
      end)

    new_list =
      list
      |> Enum.filter(&(Enum.at(&1, i) == bit))

    co2(new_list, i + 1)
  end
end
