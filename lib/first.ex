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

  @doc """
  Count the number of times the sum of measurements in this sliding window (3) increases
  """
  @spec count_in_slide_window(integer) :: integer
  def count_in_slide_window(list, old_measure \\ nil, count \\ 0)

  def count_in_slide_window(list, nil, _count) do
    measure = Enum.take(list, 3)
    new_list = Enum.drop(list, 1)
    count_in_slide_window(new_list, measure, 0)
  end

  def count_in_slide_window(list, [_a, _b, _c] = old_measure, count) do
    measure = Enum.take(list, 3)

    case length(measure) == 3 do
      true ->
        new_sum = Enum.reduce(measure, 0, &(&1 + &2))
        old_sum = Enum.reduce(old_measure, 0, &(&1 + &2))
        new_list = Enum.drop(list, 1)

        if new_sum > old_sum do
          count_in_slide_window(new_list, measure, count + 1)
        else
          count_in_slide_window(new_list, measure, count)
        end

      false ->
        count
    end
  end

  def count_in_slide_window(_list, _measure, count), do: count
end
