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
end
