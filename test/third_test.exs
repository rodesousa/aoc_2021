defmodule Third.Test do
  use ExUnit.Case
  alias Third

  test "part_one/1 with simple example" do
    assert 198 == Third.part_one("fixture/third_example.txt")
  end

  test "part_one/1 with puzzle" do
    assert 3_895_776 == Third.part_one("fixture/third.txt")
  end

  test "gama/2 with simple example" do
    assert 23 ==
             "fixture/third_example.txt"
             |> File.stream!()
             |> Stream.map(&String.trim/1)
             |> Stream.map(&String.split(&1, "", trim: true))
             |> Third.gama(0)
  end

  test "o2/2 with simple example" do
    assert 10 ==
             "fixture/third_example.txt"
             |> File.stream!()
             |> Stream.map(&String.trim/1)
             |> Stream.map(&String.split(&1, "", trim: true))
             |> Third.epsilon(0)
  end

  test "part_two/1 with simple example" do
    assert 230 ==
             Third.part_two("fixture/third_example.txt")
  end

  test "part_two/1 with puzzle" do
    assert 7_928_162 ==
             Third.part_two("fixture/third.txt")
  end
end
