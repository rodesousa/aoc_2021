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
      |> gama

    epsilon_decimal =
      gama
      |> epsilon()
      |> Enum.reduce("", fn a, acc -> "#{acc}#{a}" end)
      |> String.to_integer(2)

    gama_decimal =
      gama
      |> Enum.reduce("", fn a, acc -> "#{acc}#{a}" end)
      |> String.to_integer(2)

    epsilon_decimal * gama_decimal
  end

  @doc false
  def epsilon(gama) do
    gama
    |> Enum.map(&((&1 - 1) * -1))
  end

  defp gama(stream) do
    stream
    |> Enum.reduce({[], 0}, fn
      line, {[], 0} ->
        list =
          String.codepoints(line)
          |> Enum.map(&String.to_integer/1)

        {list, 1}

      line, {state, count} ->
        {zip_and_sum(line, state), count + 1}
    end)
    |> convert()
  end

  @doc false
  def zip_and_sum(line, state) do
    String.codepoints(line)
    |> Enum.map(&String.to_integer/1)
    |> Enum.zip(state)
    |> Enum.map(fn {a, b} ->
      a + b
    end)
  end

  @doc false
  def convert({list, count}) do
    list
    |> Enum.map(fn number ->
      if number >= count / 2, do: 1, else: 0
    end)
  end
end
