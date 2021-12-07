defmodule Fourth do
  def part_one(pathfilename) do
    [numbers | grids] =
      pathfilename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    numbers = String.split(numbers, ",")

    grids =
      grids
      |> Enum.map(&String.split(&1))
      |> Enum.map(&Enum.chunk_every(&1, 5))
      |> Enum.with_index()

    {called_numbers, index} =
      Enum.reduce_while(numbers, [], fn number, acc ->
        called_numbers = [number | acc]

        Enum.reduce_while(grids, false, fn grid, _acc ->
          case check?(grid, called_numbers) do
            true -> {:halt, {called_numbers, elem(grid, 1)}}
            false -> {:cont, false}
          end
        end)
        |> case do
          false -> {:cont, called_numbers}
          result -> {:halt, result}
        end
      end)

    {grid, _} = Enum.at(grids, index)

    grid
    |> Enum.reduce(0, fn lines, acc ->
      lines
      |> Enum.filter(&(&1 not in called_numbers))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
      |> then(&(&1 + acc))
    end)
    |> then(fn sum ->
      [last | _rest] = called_numbers
      sum * String.to_integer(last)
    end)
  end

  def check?({grid, _index}, numbers) do
    vertical = all?(grid, numbers)

    if vertical do
      true
    else
      grid
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> all?(numbers)
    end
  end

  defp all?(grid, numbers) do
    Enum.reduce_while(grid, false, fn line, _acc ->
      case Enum.all?(line, &(&1 in numbers)) do
        true -> {:halt, true}
        false -> {:cont, false}
      end
    end)
  end
end
