defmodule GameTest do
    use ExUnit.Case
    import Mock
  
    test "Creates a process holding the game state" do
      with_mock Dictionary, [random_word: fn() -> "platypus" end] do
        {:ok, pid} = Game.start_link()
        assert is_pid(pid)
        assert pid != self()
        assert called Dictionary.random_word
      end
    end



  test "initialize start_link, test if process is alive" do
    {:ok, pid} = Game.start_link
    assert true == pid |> Process.alive?
  end

  test "secret_word is part of the Disctionary.WordlList" do
    assert true == Enum.member?(Dictionary.WordList.word_list, Dictionary.random_word() |> String.trim())
  end

  test "initialization of the GenServer, remaining turn is 9" do
    with_mock Dictionary, [random_word: fn() -> "platypus" end] do
      {:ok, {secret_word, c_guesses, w_guesses, remaining_turn}} = Game.init(Dictionary.random_word() |> String.trim())
      assert "platypus" == secret_word
      assert ""         == c_guesses
      assert ""         == w_guesses
      assert 9 == remaining_turn
    end
  end

  test "submiting a guess must return :ok" do
    {:ok, pid} = Game.start_link
    assert :ok == Game.submit_guess(pid, "h")
  end

  test "get_feedback after first guess must keep 8 remaining turns and status must be playing" do
    with_mock Dictionary, [random_word: fn() -> "platypus" end] do
      {:ok, pid} = Game.start_link
      Game.submit_guess(pid, "p")
      %{feedback: feedback, remaining_turns: r_turn, status: status} = Game.get_feedback pid
      assert "p----p--" == feedback
      assert 8        == r_turn
      assert :playing == status
    end    
  end

  end