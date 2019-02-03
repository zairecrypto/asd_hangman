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
            wrong_guesses,      # "bcdef"       / ""
            remaining_turns,    # 0             / 9
        }
        ) do
        #retunr_value: "hang-an"    / "h------"
    end
end
