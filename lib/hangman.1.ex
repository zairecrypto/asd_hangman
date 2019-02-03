defmodule Hangman do
    def score_guess(
        {s_word, c_guesses , w_guesses, r_turns} = _state_of_game, letter) do

            is_correct_guess = (s_word =~ letter)
            is_memberof = fn x, y -> Enum.member?(x, y) end
            is_endOfGame = (r_turns == 0)
            
            if is_correct_guess do 
                new_c_guesses = if is_endOfGame do
                                    c_guesses
                                else
                                    [c_guesses|letter] 
                                    |> List.to_string
                                    |> String.graphemes
                                    |> Enum.uniq
                                    |> List.to_string
                                end
                 
                new_r_turn = if is_memberof.(c_guesses |> String.graphemes, letter) do
                                r_turns
                            else r_turns - 1 end

                {s_word, new_c_guesses, w_guesses, if is_endOfGame do r_turns else new_r_turn end}
                
            else
                new_w_guesses = if is_endOfGame do
                                    w_guesses
                                else 
                                    [w_guesses|letter] 
                                    |> List.to_string
                                    |> String.graphemes
                                    |> Enum.uniq
                                    |> List.to_string
                                end
                new_r_turn = if is_memberof.(w_guesses |> String.graphemes, letter) do
                                r_turns
                            else r_turns - 1end
                {s_word, c_guesses, new_w_guesses, if is_endOfGame do r_turns else new_r_turn end}                
            end
    end


    # iex(3)> c "lib/test/hangman.ex"
    # iex(4)> Hangman.unic_letters "Hangman"
    def unic_letters(secretword) do
        secretword 
        |> String.graphemes
        |> MapSet.new
    end

    def unic_letters_toString(secretword, _noUsed) do
        secretword 
        |> String.graphemes
        |> MapSet.new
        |> MapSet.to_list
        |> List.to_string
    end

    # Hangman.format_feedback/1 
    #   Tuple state_of_a_game - > {secretword, correct_guesses, wrong_guesses, remaining_turns}
    #   generates a string with the feedback for the player (e.g. “-a—a-”).

    # iex(45)> Hangman.feedback_interface({"Hangman", "aaa", "qsdqs", 4})

    def format_feedback(
        {secretword, correct_guesses, _wrong_guesses, _remaining_turns} = _state_of_a_game
        ) do
        
        c_guess = correct_guesses
                    |> String.graphemes
                    |> MapSet.new
        unic = unic_letters(secretword)
        cond do
            MapSet.disjoint?(unic, c_guess) -> lst_of_guess = unic |> MapSet.to_list
            feedbck_string = String.replace(secretword, lst_of_guess, "-")
            
            true ->
                ms_guess = MapSet.difference(unic, c_guess)
                if MapSet.size(ms_guess) > 0 do
                    lst_of_guess = MapSet.to_list(ms_guess)
                    feedbck_string = String.replace(secretword, lst_of_guess, "-")
                    feedbck_string
                else
                    "ERROR"
                end
        end
    end


end