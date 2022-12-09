defmodule DayOne do
  def part_one do
    get_input()
    |> Enum.reduce(0, &run_one/2)
  end

  def part_two do
    get_input()
    |> Enum.map(&get_sum/1)
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.sum()
  end

  defp run_one(list, acc) do
    sum = get_sum(list)

    if sum >= acc do
      sum
    else
      acc
    end
  end

  defp get_sum(list) do
    list
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end

DayOne.part_one() |> IO.inspect(label: "PART ONE ANSWER")
DayOne.part_two() |> IO.inspect(label: "PART TWO ANSWER")
