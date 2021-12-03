defmodule Third.Test do
  use ExUnit.Case
  alias Third

  test "part_one/1 with simple example" do
    assert 198 == Third.part_one("fixture/third_example.txt")
  end

  test "compute/1 part one" do
    assert 198 == Third.part_one("fixture/third.txt")
  end

  test "convert/1" do
    assert [1, 0] = Third.convert({[5, 2], 5})
  end

  test "zip_state/2" do
    assert [3, 4, 4, 5] == Third.zip_and_sum("1100", [2, 3, 4, 5])
  end

  test "epsilon/1" do
    assert [0, 1, 0] == Third.epsilon([1, 0, 1])
  end
end
