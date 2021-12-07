defmodule FourtTest do
  use ExUnit.Case
  alias Fourth

  test "part_one/1 with example" do
    assert 4512 == Fourth.part_one("fixture/fourth_example.txt")
  end

  test "part_one/1 with puzzle" do
    assert 82440 == Fourth.part_one("fixture/fourth.txt")
  end
end
