defmodule FirstTest do
  use ExUnit.Case
  alias First

  test "read_file/1" do
    assert {:ok, list} = First.read_file("fixture/first.txt")
  end

  test "count_larger_than_previous_measurements/1 with simple example" do
    assert 7 ==
             FT.count_larger_than_previous_measurements([
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

  test "count_larger_than_previous_measurements/1 with puzzle input" do
    # assert ?? ==
    #         "fixture/first.txt" |> FT.read_file() |> FT.count_larger_than_previous_measurements()
    assert false
  end
end
