defmodule DaySeven do
  @required_space 30_000_000
  @total_space 70_000_000

  def part_one do
    get_input()
    |> Enum.map(&String.split/1)
    |> Enum.reduce({nil, %{}}, &run/2)
    |> then(fn {_path, sizes} ->
      sizes
      |> Enum.reduce(0, fn {_k, size}, acc ->
        if size <= 100_000 do
          acc + size
        else
          acc
        end
      end)
    end)
  end

  def part_two do
    get_input()
    |> Enum.map(&String.split/1)
    |> Enum.reduce({nil, %{}}, &run/2)
    |> then(fn {_path, sizes} ->
      unused_space = @total_space - Map.get(sizes, "/")
      required_space = @required_space - unused_space

      sizes
      |> Map.values()
      |> Enum.sort()
      |> Enum.find(&(&1 >= required_space))
    end)
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp run(["$", "cd", "/"], {_path, sizes}), do: {Path.rootname("/"), Map.put(sizes, "/", 0)}

  defp run(["$", "cd", ".."], {path, sizes}), do: {parent_dir(path), sizes}

  defp run(["$", "cd", dir], {path, sizes}) do
    path
    |> Path.join(dir)
    |> then(&{&1, Map.put(sizes, &1, 0)})
  end

  defp run(["dir", _], acc), do: acc
  defp run(["$", _], acc), do: acc

  defp run([size, _], {path, sizes}) do
    sizes
    |> Enum.reduce(sizes, fn {k, _v}, acc ->
      if String.contains?(path, k) do
        Map.update!(acc, k, &(&1 + String.to_integer(size)))
      else
        acc
      end
    end)
    |> then(&{path, &1})
  end

  defp run(_, acc), do: acc

  defp parent_dir(path) do
    path
    |> Path.split()
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
    |> Path.join()
  end
end

DaySeven.part_one() |> IO.inspect(label: "PART ONE ANSWER")
DaySeven.part_two() |> IO.inspect(label: "PART TWO ANSWER")
