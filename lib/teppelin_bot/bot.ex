defmodule TeppelinBot.Bot do
	alias TeppelinBot.TwitchTV
  @bot :teppelin_bot
		
  use ExGram.Bot, name: @bot

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Hi! I'm Teppelin Bot")
  end

	def handle({:command, "get_top_games", msg}, context) do
		top_games =
			with {val, _ } when val >= 1 <- Integer.parse(msg)  do
				TwitchTV.get_top_games(val)
			else _ -> 
				TwitchTV.get_top_games()
			end
		case top_games do
			:error -> "Unexpected error 😰"
			_ -> top_games.join("\n")
		end
	end

end

