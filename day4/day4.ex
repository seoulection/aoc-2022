defmodule DayFour do
  def run do
    get_input()
    |> Enum.reduce(0, fn dirty_str, acc ->
      [first, second] = String.split(dirty_str, ",")

      [x1, x2] =
        list1 =
        first
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      [y1, y2] =
        list2 =
        second
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      [_a, b, c, _d] = Enum.sort(list1 ++ list2)

      if (b == x1 and c == x2) or (b == y1 and c == y2) do
        acc + 1
      else
        acc
      end
    end)
  end

  def run_two do
    get_input()
    |> Enum.reduce(0, fn dirty_str, acc ->
      [first, second] = String.split(dirty_str, ",")

      [x1, x2] =
        list1 =
        first
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      [y1, y2] =
        list2 =
        second
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      [a, b, c, _d] = Enum.sort(list1 ++ list2)

      if ((a == x1 and b == x2) or (a == y1 and b == y2)) and b !== c do
        acc
      else
        acc + 1
      end
    end)
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end
end

IO.inspect(DayFour.run(), label: "PART ONE ANSWER")
IO.inspect(DayFour.run_two(), label: "PART TWO ANSWER")
