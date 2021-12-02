defmodule FirstTest do
  use ExUnit.Case
  alias First

  test "read_file!/1" do
    list = First.read_file!("fixture/first.txt")
    assert Enum.all?(list, &is_integer/1)
    assert [124, 125 | _rest] = list
  end

  test "count_larger_than_previous_measurement/1 with simple example" do
    assert 7 ==
             First.count_larger_than_previous_measurement([
               199,
               200,
               208,
               210,
               200,
               207,
               240,
               269,
               260,
               263
             ])
  end

  test "count_larger_than_previous_measurement/1 with puzzle input" do
    assert 1559 ==
             "fixture/first.txt"
             |> First.read_file!()
             |> First.count_larger_than_previous_measurement()
  end
end
