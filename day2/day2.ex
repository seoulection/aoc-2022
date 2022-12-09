defmodule DayTwo do
  @part_one %{
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6
  }

  @part_two %{
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7
  }

  def run(map) do
    get_input()
    |> Enum.map(&map[&1])
    |> Enum.sum()
  end

  def part_one_map, do: @part_one
  def part_two_map, do: @part_two

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end
end

DayTwo.run(DayTwo.part_one_map()) |> IO.inspect(label: "PART ONE ANSWER")
DayTwo.run(DayTwo.part_two_map()) |> IO.inspect(label: "PART TWO ANSWER")
