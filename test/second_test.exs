defmodule SecondTest do
  use ExUnit.Case
  alias Second

  @example [
    ["forward", "5"],
    ["down", "5"],
    ["forward", "8"],
    ["up", "3"],
    ["down", "8"],
    ["forward", "2"]
  ]

  test "read_file/1" do
    assert ["forward", "4"] ==
             Second.read_file!("fixture/second.txt")
             |> List.first()
  end

  test "compute/1 with simple example" do
    assert 150 ==
             Second.compute(@example)
  end

  test "compute/1 with puzzle part 1" do
    assert 150 ==
             "fixture/second.txt"
             |> Second.read_file!()
             |> Second.compute()
  end

  test "compute_aim/1 with simple example" do
    assert 900 == Second.compute_aim(@example)
  end

  test "compute/1 with puzzle part 2" do
    assert 1_544_000_595 ==
             "fixture/second.txt"
             |> Second.read_file!()
             |> Second.compute_aim()
  end
end
