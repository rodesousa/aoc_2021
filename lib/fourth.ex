defmodule Fourth do
  defstruct called_numbers: [], grids: [], last_index: [], called_winning_numbers: []

  def part_one(pathfilename) do
    [numbers | grids] = read(pathfilename)
    numbers = String.split(numbers, ",")
    grids = grid_builder(grids)

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

    score(grids, index, called_numbers)
  end

  def part_two(pathfilename) do
    [numbers | grids] = read(pathfilename)
    numbers = String.split(numbers, ",")
    grids = grid_builder(grids)

    part2 = %Fourth{grids: grids}

    %Fourth{last_index: index, called_winning_numbers: called_numbers} =
      Enum.reduce_while(numbers, part2, fn number, acc ->
        if Enum.empty?(acc.grids), do: {:halt, acc}

        called_numbers = [number | acc.called_numbers]

        Enum.reduce_while(acc.grids, false, fn grid, _acc ->
          case check?(grid, called_numbers) do
            true -> {:halt, {called_numbers, elem(grid, 1)}}
            false -> {:cont, false}
          end
        end)
        |> case do
          false ->
            {:cont, %Fourth{acc | called_numbers: called_numbers}}

          {winning_numbers, index} ->
            pp = %Fourth{
              acc
              | grids: Enum.filter(acc.grids, &(elem(&1, 1) != index)),
                last_index: index,
                called_winning_numbers: winning_numbers,
                called_numbers: called_numbers
            }

            {:cont, pp}
        end
      end)

    score(grids, index, called_numbers)
  end

  defp check?({grid, _index}, numbers) do
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

  defp read(pathfilename) do
    pathfilename
    |> File.read!()
    |> String.split("\n\n", trim: true)
  end

  defp grid_builder(grids) do
    grids
    |> Enum.map(&String.split(&1))
    |> Enum.map(&Enum.chunk_every(&1, 5))
    |> Enum.with_index()
  end

  defp score(grids, index, called_numbers) do
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
end
