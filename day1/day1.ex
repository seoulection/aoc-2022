list =
  "input.txt"
  |> File.read!()
  |> String.trim_trailing()
  |> String.split("\n\n")

num_string_to_num_list = fn num_string ->
  num_string
  |> String.split("\n")
  |> Enum.map(&String.to_integer/1)
end

# PART ONE
list
|> Enum.reduce(0, fn num_string, acc ->
  num_string
  |> num_string_to_num_list.()
  |> Enum.reduce(fn num, acc -> num + acc end)
  |> then(fn max ->
    if max > acc do
      max
    else
      acc
    end
  end)
end)
|> IO.inspect(label: "PART ONE ANSWER")

# PART TWO
list
|> Enum.map(fn num_string ->
  num_string
  |> num_string_to_num_list.()
  |> Enum.reduce(fn num, acc -> num + acc end)
end)
|> Enum.sort(:desc)
|> then(fn [first, second, third | _rest] ->
  first + second + third
end)
|> IO.inspect(label: "PART TWO ANSWER")
