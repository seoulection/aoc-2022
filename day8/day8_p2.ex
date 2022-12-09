defmodule DayEightPartTwo do
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

  defp recur1(list, index, count) when index == length(list) - 1, do: count

  defp recur1(list, 0 = index, _count),
    do: recur1(list, index + 1, 0)

  defp recur1(list, index, count) do
    list
    |> Enum.at(index)
    |> recur2(@starting_index, count, list, index)
    |> then(&recur1(list, index + 1, &1))
  end

  defp recur2(list1, index1, count, _list2, _index2) when index1 == length(list1) - 1,
    do: count

  defp recur2(list1, 0 = index1, count, list2, index2),
    do: recur2(list1, index1 + 1, count, list2, index2)

  defp recur2(list1, index1, count, list2, index2) do
    num = Enum.at(list1, index1)

    num
    |> calculate_score(list1, index1)
    |> Kernel.*(calculate_score(num, get_transposed_list(list2, index1), index2))
    |> case do
      score when score > count ->
        score

      _ ->
        count
    end
    |> then(&recur2(list1, index1 + 1, &1, list2, index2))
  end

  defp calculate_score(num, list, index) do
    list1 =
      list
      |> Enum.slice(0..(index - 1))
      |> Enum.reverse()

    list2 = Enum.slice(list, (index + 1)..(Enum.count(list) - 1))

    calculate_score2(num, list1, @starting_index) * calculate_score2(num, list2, @starting_index)
  end

  defp calculate_score2(_target, [], index), do: index

  defp calculate_score2(target, [num | _rest], index) when target <= num,
    do: index + 1

  defp calculate_score2(target, [num | rest], index) when target > num,
    do: calculate_score2(target, rest, index + 1)

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

DayEightPartTwo.run() |> IO.inspect(label: "PART TWO ANSWER")
