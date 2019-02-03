defmodule HangmanTest do
  use ExUnit.Case


  test "Works with 'hangman' and one correct letter first test" do
    assert {"hangman", "h", "", 9} = Hangman.score_guess({"hangman", "", "", 10}, "h")
  end
  # the rest of this file can be checked in the project's code

  # @tag :skip
  test "Works with 'hangman' and one correct letter" do
    assert {_, "h", "", 8} = Hangman.score_guess({"hangman", "", "", 9}, "h")
    assert {_, "a", "", 8} = Hangman.score_guess({"hangman", "", "", 9}, "a")
    assert {_, "n", "", 8} = Hangman.score_guess({"hangman", "", "", 9}, "n")
    assert {_, "g", "", 8} = Hangman.score_guess({"hangman", "", "", 9}, "g")
    assert {_, "m", "", 8} = Hangman.score_guess({"hangman", "", "", 9}, "m")
  end

  # @tag :skip
  test "Works with 'hangman' and two correct letters" do
    assert {_, "ha", "", 7} = {"hangman", "", "", 9} |> Hangman.score_guess("h") |> Hangman.score_guess("a")
    assert {_, "ng", "", 7} = {"hangman", "", "", 9} |> Hangman.score_guess("n") |> Hangman.score_guess("g")
    assert {_, "ah", "", 7} = {"hangman", "", "", 9} |> Hangman.score_guess("a") |> Hangman.score_guess("h")
  end

  # @tag :skip
  test "Works with 'hangman' and three correct letters" do
    Enum.map(1..5, fn _ ->
      seq = Enum.take_random(~w[h a n g m], 3)
      corr = Enum.join(seq)
      assert {_, ^corr, "", 6} = Enum.reduce(seq, {"hangman", "", "", 9}, fn letter, acc -> Hangman.score_guess(acc, letter) end)
    end)
  end

  # @tag :skip
  test "Works with 'hangman'; correct and incorrect letters" do
    assert {_, "ha", "x", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("h") |> Hangman.score_guess("a") |> Hangman.score_guess("x")
    assert {_, "ng", "w", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("n") |> Hangman.score_guess("w") |> Hangman.score_guess("g")
    assert {_, "ah", "y", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("y") |> Hangman.score_guess("a") |> Hangman.score_guess("h")
  end

  # @tag :skip
  test "Works with 'hangman'; correct, incorrect and duplicate letters" do
    assert {_, "ha", "x", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("h") |> Hangman.score_guess("a") |> Hangman.score_guess("x") |> Hangman.score_guess("h")
    assert {_, "ng", "w", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("n") |> Hangman.score_guess("w") |> Hangman.score_guess("w") |> Hangman.score_guess("g")
    assert {_, "ah", "y", 6} = {"hangman", "", "", 9} |> Hangman.score_guess("y") |> Hangman.score_guess("a") |> Hangman.score_guess("h") |> Hangman.score_guess("a")
  end

  # @tag :skip
  test "Works with 'hangman' and handles end of game" do
    assert {"hangman", "", "bcdefijkl", 0} = {"hangman", "", "bcdefijkl", 0} |> Hangman.score_guess("h")
    assert {"hangman", "a", "bcefijkl", 0} = {"hangman", "a", "bcefijkl", 0} |> Hangman.score_guess("n") |> Hangman.score_guess("w")
    assert {"hangman", "ahgn", "bcdef", 0} = {"hangman", "ahgn", "bcdef", 0} |> Hangman.score_guess("y")
  end

  # @tag :skip
  test "Formats feedback" do
    assert "hang-an" == Hangman.format_feedback({"hangman", "ahgn", "bcdef", 0})
    assert "--i-tst--e" == Hangman.format_feedback({"flintstone", "etis", "bc", 4})
    assert "f-i-tsto-e" == Hangman.format_feedback({"flintstone", "etisof", "bc", 2})
    assert "-------" == Hangman.format_feedback({"hangman", "", "bcdefijkl", 0})
  end

end
