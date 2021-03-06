defmodule Hangman do
    def score_guess(
        {
            secret_word,        # "hangman"
            correct_guesses,    # ""
            wrong_guesses,      # ""
            remaining_turns     # 10
        } = _state_of_game, 
        player_guess            # "h"
        ) do


            # "hangman" =~ "h" 
            # true
            is_correct_guess    = (secret_word =~ player_guess)

            is_memberof         = fn x, y -> Enum.member?(x, y) end
            
            is_endOfGame        = (remaining_turns == 0)

            if is_correct_guess do
                new_correct_guesses = 
                    if is_endOfGame do
                        correct_guesses
                    else
                        [correct_guesses | player_guess]
                        |> List.to_string
                        |> String.graphemes
                        |> Enum.uniq
                        |> List.to_string
                    end
                
                new_remaining_turns =
                    if is_memberof.(correct_guesses |> String.graphemes, player_guess) do
                        remaining_turns
                    else
                        remaining_turns - 1
                    end
                
                # Return value
                {
                    secret_word, 
                    new_correct_guesses, 
                    wrong_guesses, 
                    if is_endOfGame do
                        remaining_turns
                    else
                        new_remaining_turns
                    end
                }
            else

                new_wrong_guesses = 
                    if is_endOfGame do
                        wrong_guesses
                    else
                        [wrong_guesses | player_guess]
                        |> List.to_string
                        |> String.graphemes
                        |> Enum.uniq
                        |> List.to_string
                    end
                
                new_remaining_turns =
                    if is_memberof.(wrong_guesses |> String.graphemes, player_guess) do
                        remaining_turns
                    else
                        remaining_turns - 1
                    end
                
                # Return value
                {
                    secret_word, 
                    correct_guesses, 
                    new_wrong_guesses, 
                    if is_endOfGame do
                        remaining_turns
                    else
                        new_remaining_turns
                    end
                }                
            end

    end



    def format_feedback(
        {
            secret_word,        # "hangman"     / "hangman"
            correct_guesses,    # "ahgn"        / "h"
            _wrong_guesses,      # "bcdef"       / ""
            _remaining_turns,    # 0             / 9
        }
        ) do

            correct_guess_MapSet    = unic_letters correct_guesses
            unic                    = unic_letters secret_word

            cond do
                MapSet.disjoint?(unic, correct_guess_MapSet)    -> 
                    feedback_string = String.replace(
                        secret_word, 
                        unic |> MapSet.to_list, 
                        "-"
                        )
                true                                            ->
                    ms_guess = MapSet.difference(unic, correct_guess_MapSet)
                    if MapSet.size(ms_guess) > 0 do
                        feedback_string = String.replace(
                            secret_word, 
                            MapSet.to_list(ms_guess), 
                            "-"
                        )
                        feedback_string
                    else
                        "ERROR 0001"
                    end
            end
    end

    defp unic_letters(secret_word) do 
        secret_word             # "ahgn" |> String.graphemes
        |> String.graphemes     # ["a", "h", "g", "n"]
        |> MapSet.new           # #MapSet<["a", "g", "h", "n"]>
    end 

    defp unic_letters_toString(secret_word, _) do
        unic_letters(secret_word)
        |> MapSet.to_list
        |> List.to_string
    end


end
