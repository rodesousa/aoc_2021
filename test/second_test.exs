defmodule SecondTest do
  use ExUnit.Case
  alias Second

  test "read_file/1" do
    assert ["forward", "4"] ==
             Second.read_file!("fixture/second.txt")
             |> List.first()
  end

  test "compute/1 with simple example" do
    assert 150 ==
             Second.compute([
               ["forward", "5"],
               ["down", "5"],
               ["forward", "8"],
               ["up", "3"],
               ["down", "8"],
               ["forward", "2"]
             ])
  end

  test "compute/1 with puzzle part 1" do
    assert 150 ==
             "fixture/second.txt"
             |> Second.read_file!()
             |> Second.compute()
  end
end
