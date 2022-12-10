defmodule DayTenPartTwo do
  @dot "."
  @pixel "#"
  @initial_value 1
  @ending_row 6
  @starting_crt 0
  @starting_row 0
  @crt_limit 40

  def run do
    get_input()
    |> recur(
      @initial_value,
      false,
      @starting_crt,
      @starting_row,
      initial_store()
    )
    |> Enum.map(&Enum.join/1)
  end

  defp recur([], _value, _addx_cycle, _crt, _row, store), do: store
  defp recur(_list, _value, _addx_cycle, _crt, @ending_row, store), do: store

  defp recur([["noop"] | _rest] = list, value, addx_cycle, crt, row, store)
       when crt == @crt_limit do
    recur(list, value, addx_cycle, @starting_crt, row + 1, store)
  end

  defp recur([["noop"] | rest], value, addx_cycle, crt, row, store)
       when crt in [value - 1, value, value + 1] do
    store
    |> Enum.at(row)
    |> List.replace_at(crt, @pixel)
    |> then(&recur(rest, value, addx_cycle, crt + 1, row, List.replace_at(store, row, &1)))
  end

  defp recur([["noop"] | rest], value, addx_cycle, crt, row, store) do
    recur(rest, value, addx_cycle, crt + 1, row, store)
  end

  defp recur([["addx", _to_add] | _rest] = list, value, false, crt, row, store)
       when crt == @crt_limit do
    recur(list, value, false, @starting_crt, row + 1, store)
  end

  defp recur([["addx", _to_add] | _rest] = list, value, false, crt, row, store)
       when crt in [value - 1, value, value + 1] do
    store
    |> Enum.at(row)
    |> List.replace_at(crt, @pixel)
    |> then(&recur(list, value, true, crt + 1, row, List.replace_at(store, row, &1)))
  end

  defp recur([["addx", _to_add] | _rest] = list, value, false, crt, row, store) do
    recur(list, value, true, crt + 1, row, store)
  end

  defp recur([["addx", _to_add] | _rest] = list, value, true, crt, row, store)
       when crt == @crt_limit do
    recur(list, value, true, @starting_crt, row + 1, store)
  end

  defp recur([["addx", to_add] | rest], value, true, crt, row, store)
       when crt in [value - 1, value, value + 1] do
    new_value =
      to_add
      |> String.to_integer()
      |> Kernel.+(value)

    store
    |> Enum.at(row)
    |> List.replace_at(crt, @pixel)
    |> then(&recur(rest, new_value, false, crt + 1, row, List.replace_at(store, row, &1)))
  end

  defp recur([["addx", to_add] | rest], value, true, crt, row, store) do
    to_add
    |> String.to_integer()
    |> Kernel.+(value)
    |> then(&recur(rest, &1, false, crt + 1, row, store))
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end

  defp initial_store do
    @dot
    |> List.duplicate(40)
    |> List.duplicate(6)
  end
end

IO.puts("PART TWO ANSWER")
DayTenPartTwo.run() |> IO.inspect()
