defmodule DayEightPartOne do
  @initial_count 0
  @starting_index 0

  def run do
    get_input()
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(fn x ->
      Enum.map(x, &String.to_integer/1)
    end)
    |> recur1(@starting_index, @initial_count)
  end

  defp recur1(list, index, count) when index == length(list) - 1, do: count + Enum.count(list)

  defp recur1(list, 0 = index, count),
    do: recur1(list, index + 1, count + Enum.count(list))

  defp recur1(list, index, count) do
    list
    |> Enum.at(index)
    |> recur2(@starting_index, count, list, index)
    |> then(&recur1(list, index + 1, &1))
  end

  defp recur2(list1, index1, count, _list2, _index2) when index1 == length(list1) - 1,
    do: count + 1

  defp recur2(list1, 0 = index1, count, list2, index2),
    do: recur2(list1, index1 + 1, count + 1, list2, index2)

  defp recur2(list1, index1, count, list2, index2) do
    num = Enum.at(list1, index1)

    if is_visible(num, list1, index1) or
         is_visible(num, get_transposed_list(list2, index1), index2) do
      recur2(list1, index1 + 1, count + 1, list2, index2)
    else
      recur2(list1, index1 + 1, count, list2, index2)
    end
  end

  defp is_visible(num, list, index) do
    max1 =
      list
      |> Enum.slice(0..(index - 1))
      |> Enum.max()

    max2 =
      list
      |> Enum.slice((index + 1)..(Enum.count(list) - 1))
      |> Enum.max()

    num > max1 or num > max2
  end

  defp get_transposed_list(list, index) do
    list
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.at(index)
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end

{time, _} = :timer.tc(fn -> DayEightPartOne.run() |> IO.inspect(label: "PART ONE ANSWER") end)
IO.inspect(time / 1_000_000, label: "TIME ELAPSED IN SECONDS")
