defmodule DayTwo do
  @my_rock "X"
  @my_paper "Y"
  @my_scissors "Z"
  @opp_rock "A"
  @opp_paper "B"
  @opp_scissors "C"
  @rock_score 1
  @paper_score 2
  @scissors_score 3
  @draw 3
  @win 6
  @lose_code "X"
  @draw_code "Y"
  @win_code "Z"

  def run(fun) do
    get_input()
    |> Enum.reduce(0, fn game_string, acc ->
      first = String.at(game_string, 0)
      second = String.at(game_string, 2)

      acc + fun.(first, second)
    end)
  end

  defp get_input do
    "input.txt"
    |> File.read!()
    |> String.trim_trailing()
    |> String.split("\n")
  end

  def calculate_part_one_score(@opp_rock, @my_rock), do: @draw + @rock_score
  def calculate_part_one_score(@opp_rock, @my_paper), do: @win + @paper_score
  def calculate_part_one_score(@opp_rock, @my_scissors), do: @scissors_score
  def calculate_part_one_score(@opp_paper, @my_rock), do: @rock_score
  def calculate_part_one_score(@opp_paper, @my_paper), do: @draw + @paper_score
  def calculate_part_one_score(@opp_paper, @my_scissors), do: @win + @scissors_score
  def calculate_part_one_score(@opp_scissors, @my_rock), do: @win + @rock_score
  def calculate_part_one_score(@opp_scissors, @my_paper), do: @paper_score
  def calculate_part_one_score(@opp_scissors, @my_scissors), do: @draw + @scissors_score

  def calculate_part_two_score(@opp_rock, @draw_code), do: @draw + @rock_score
  def calculate_part_two_score(@opp_rock, @lose_code), do: @scissors_score
  def calculate_part_two_score(@opp_rock, @win_code), do: @win + @paper_score
  def calculate_part_two_score(@opp_paper, @draw_code), do: @draw + @paper_score
  def calculate_part_two_score(@opp_paper, @lose_code), do: @rock_score
  def calculate_part_two_score(@opp_paper, @win_code), do: @win + @scissors_score
  def calculate_part_two_score(@opp_scissors, @draw_code), do: @draw + @scissors_score
  def calculate_part_two_score(@opp_scissors, @lose_code), do: @paper_score
  def calculate_part_two_score(@opp_scissors, @win_code), do: @win + @rock_score
end

DayTwo.run(&DayTwo.calculate_part_one_score/2)
|> IO.inspect(label: "PART ONE ANSWER")

DayTwo.run(&DayTwo.calculate_part_two_score/2)
|> IO.inspect(label: "PART ONE ANSWER")
