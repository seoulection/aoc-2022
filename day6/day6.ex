defmodule DaySix do
  def run do
    "input.txt"
    |> File.read!()
    |> String.split("", trim: true)
    |> detect_marker(4, 4)
  end

  def run_two do
    "input.txt"
    |> File.read!()
    |> String.split("", trim: true)
    |> detect_marker(14, 14)
  end

  defp detect_marker([_head | rest] = list, scan_num, slice_num) do
    list
    |> get_counts(slice_num)
    |> Enum.uniq()
    |> Enum.count()
    |> case do
      1 ->
        scan_num

      _ ->
        detect_marker(rest, scan_num + 1, slice_num)
    end
  end

  defp get_counts(list, slice_num) do
    list
    |> Enum.slice(0..(slice_num - 1))
    |> then(&[Enum.count(&1), &1 |> Enum.uniq() |> Enum.count()])
  end
end

DaySix.run() |> IO.inspect(label: "PART ONE ANSWER")
DaySix.run_two() |> IO.inspect(label: "PART TWO ANSWER")
