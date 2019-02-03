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
                
            else
            end




        #return_value: {"hangman", "h", "", 9} 
        {
            secret_word, 
            player_guess, 
            "", 
            remaining_turns-1
        } 
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
