defmodule DayTenPartOne do
  @initial_value 1
  @ending_addx_cycle 2
  @starting_addx_cycle 1
  @starting_cycle 1
  @store []
  @desired_cycles [20, 60, 100, 140, 180, 220]

  def run do
    get_input()
    |> recur(@initial_value, @starting_addx_cycle, @starting_cycle, @store)
    |> Enum.sum()
  end

  defp recur([], _value, _addx_cycle, _cycle, store), do: store

  defp recur([["noop"] | rest], value, addx_cycle, cycle, store) when cycle in @desired_cycles,
    do: recur(rest, value, addx_cycle, cycle + 1, [value * cycle | store])

  defp recur([["noop"] | rest], value, addx_cycle, cycle, store),
    do: recur(rest, value, addx_cycle, cycle + 1, store)

  defp recur([["addx", _to_add] | _rest] = list, value, @starting_addx_cycle, cycle, store)
       when cycle in @desired_cycles,
       do: recur(list, value, @ending_addx_cycle, cycle + 1, [value * cycle | store])

  defp recur([["addx", _to_add] | _rest] = list, value, @starting_addx_cycle, cycle, store),
    do: recur(list, value, @ending_addx_cycle, cycle + 1, store)

  defp recur([["addx", to_add] | rest], value, @ending_addx_cycle, cycle, store)
       when cycle in @desired_cycles do
    to_add
    |> String.to_integer()
    |> Kernel.+(value)
    |> then(&recur(rest, &1, @starting_addx_cycle, cycle + 1, [value * cycle | store]))
  end

  defp recur([["addx", to_add] | rest], value, @ending_addx_cycle, cycle, store) do
    to_add
    |> String.to_integer()
    |> Kernel.+(value)
    |> then(&recur(rest, &1, @starting_addx_cycle, cycle + 1, store))
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end
end

DayTenPartOne.run() |> IO.inspect(label: "PART ONE ANSWER")
