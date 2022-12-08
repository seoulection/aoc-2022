defmodule DayFive do
  def run(fun) do
    [head | [rest]] = get_input()
    grid = get_grid(head)

    rest
    |> get_instructions()
    |> Enum.reduce(grid, fn [amount, origin, dest], acc ->
      origin_list = Enum.at(acc, origin)
      dest_list = Enum.at(acc, dest)

      to_add =
        origin_list
        |> Enum.slice((amount * -1)..-1)
        |> fun.()

      acc
      |> List.replace_at(origin, Enum.drop(origin_list, amount * -1))
      |> List.replace_at(dest, dest_list ++ to_add)
    end)
    |> Enum.map(fn list ->
      List.last(list)
    end)
    |> Enum.join("")
  end

  defp get_grid(list) do
    list
    |> input_to_list()
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn el ->
      [_head | rest] = Enum.reverse(el)

      Enum.reject(rest, fn x -> x == " " end)
    end)
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n\n")
  end

  defp input_to_list(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [_ | rest] = String.split(line, "", trim: true)

      Enum.take_every(rest, 4)
    end)
  end

  defp get_instructions(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn line ->
      line = String.split(line, " ")

      amount = convert_to_integer(line, 1)
      origin = convert_to_integer(line, 3)
      dest = convert_to_integer(line, 5)

      [amount, origin - 1, dest - 1]
    end)
  end

  defp convert_to_integer(line, index) do
    line
    |> Enum.at(index)
    |> String.to_integer()
  end
end

IO.inspect(DayFive.run(&Enum.reverse/1), label: "PART ONE ANSWER")
IO.inspect(DayFive.run(fn x -> x end), label: "PART TWO ANSWER")
