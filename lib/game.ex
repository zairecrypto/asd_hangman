defmodule Game do
    use GenServer

    def start_link() do
        secret_word = Dictionary.random_word() |> String.trim()
        GenServer.start_link(__MODULE__, secret_word)
    end
    
    def init(secret_word) do
        {:ok, {secret_word, "", "", 9}}
    end

    def submit_guess(pid, letter) do
        GenServer.cast(pid, {:submit_guess, letter})
    end
 
    def get_feedback(pid) do
        GenServer.call(pid, {:get_feedback})
    end

    def handle_cast({:submit_guess, letter}, state) do
        {:noreply, Hangman.score_guess(state, letter)}
    end

    def handle_call({:get_feedback}, _from, {word,_,_,remaining_turns} = state) do
        feedback = Hangman.format_feedback(state)
        status =
            cond do
                feedback == word -> :win
                remaining_turns == 0 -> :lose
                true -> :playing
            end
        if status == :playing do
            {:reply, %{feedback: feedback, status: status, remaining_turns: remaining_turns}, state}
        else
            {:reply, %{feedback: feedback, status: status, remaining_turns: remaining_turns, secret: word}, state}
        end
    end
end