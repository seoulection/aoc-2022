defmodule DayThree do
  def run do
    ultimate_map = ultimate_map()

    get_input()
    |> Enum.reduce(0, fn str, acc ->
      mid =
        str
        |> String.length()
        |> Kernel./(2)
        |> trunc()

      str
      |> String.split_at(mid)
      |> then(fn {one, two} ->
        one_map =
          one
          |> String.split("", trim: true)
          |> Enum.reduce(%{}, fn letter, acc ->
            Map.put(acc, letter, Map.get(ultimate_map, letter))
          end)

        value =
          two
          |> String.split("", trim: true)
          |> find_value(one_map)

        acc + value
      end)
    end)
  end

  def run_two do
    ultimate_map = ultimate_map()

    get_input()
    |> Enum.chunk_every(3)
    |> Enum.reduce(0, fn [first, second, third], acc ->
      list = String.split(first, "", trim: true)

      map2 =
        second
        |> String.split("", trim: true)
        |> create_map(ultimate_map)

      map3 =
        third
        |> String.split("", trim: true)
        |> create_map(ultimate_map)

      acc + find_item(list, map2, map3)
    end)
  end

  defp find_item([head | rest], map1, map2) do
    if not is_nil(Map.get(map1, head)) and not is_nil(Map.get(map2, head)) do
      Map.get(map1, head)
    else
      find_item(rest, map1, map2)
    end
  end

  defp create_map(list, ultimate_map) do
    Enum.reduce(list, %{}, fn letter, acc ->
      Map.put(acc, letter, Map.get(ultimate_map, letter))
    end)
  end

  defp find_value([head | rest], one_map) do
    case Map.get(one_map, head) do
      nil ->
        find_value(rest, one_map)

      value ->
        value
    end
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end

  defp ultimate_map do
    lowercase_alphabet =
      for n <- ?a..?z,
          do: <<n::utf8>>

    uppercase_alphabet =
      for n <- ?A..?Z,
          do: <<n::utf8>>

    lower_priority = Enum.to_list(1..26)
    upper_priority = Enum.to_list(27..52)

    lower = Enum.zip(lowercase_alphabet, lower_priority)
    upper = Enum.zip(uppercase_alphabet, upper_priority)

    (lower ++ upper)
    |> Enum.reduce(%{}, fn {letter, value}, acc ->
      Map.put(acc, letter, value)
    end)
  end
end

IO.inspect(DayThree.run(), label: "PART ONE ANSWER")
IO.inspect(DayThree.run_two(), label: "PART TWO ANSWER")
