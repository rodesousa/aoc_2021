defmodule Third.Test do
  use ExUnit.Case
  alias Third

  test "part_one/1 with simple example" do
    assert 198 == Third.part_one("fixture/third_example.txt")
  end

  test "part_one/1 part one" do
    assert 3_895_776 == Third.part_one("fixture/third.txt")
  end
end
