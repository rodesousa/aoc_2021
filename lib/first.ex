defmodule First do
  @moduledoc """
  https://adventofcode.com/2021/day/1
  """

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
        measure, acc -> [String.to_integer(measure) | acc]
      end
    )
    |> Enum.reverse()
  end

  @doc """
  Count how many number are larger than the previous
  """
  @spec count_larger_than_previous_measurement([integer()]) :: integer()
  def count_larger_than_previous_measurement(list) do
    {count, _old} =
      list
      |> Enum.reduce({0, nil}, fn
        measure, {0, nil} ->
          {0, measure}

        measure, {count, old} ->
          if measure > old, do: {count + 1, measure}, else: {count, measure}
      end)

    count
  end
end
