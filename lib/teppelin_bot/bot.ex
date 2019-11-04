defmodule TeppelinBot.Bot do
  alias TeppelinBot.TwitchTV
  @bot :teppelin_bot

  use ExGram.Bot, name: @bot

  require Logger

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Hi! I'm Teppelin Bot")
  end

  def handle({:command, "get_top_games", %{text: text}}, context) do
    top_games =
      with n when n >= 1 <- parseNaturalNumber(text) do
        TwitchTV.get_top_games(n)
      else _ ->
        TwitchTV.get_top_games()
      end
    result =
      case top_games do
        :error -> "Unexpected error 😰"
        _ -> "*Rank|Game*\n#{Enum.join(top_games, "\n")}"
      end

    answer(context, result, parse_mode: "Markdown")
  end

  def handle({:command, "get_top_streams", %{text: text}}, context) do
  	top_streams =
	  	with n when n >= 1 <- parseNaturalNumber(text) do
	  		TwitchTV.get_top_streams(n)
	  	else _ -> 
	  		TwitchTV.get_top_streams()
	  	end
  	result =
  		case top_streams do
        :error -> "Unexpected error 😰"
        _ -> "*Rank|Title*\n#{Enum.join(top_streams, "\n")}"
      end

      answer(context, result, parse_mode: "Markdown")
  end

  defp parseNaturalNumber(txt) do
  	try do
        String.to_integer(txt)
      rescue
        _ -> 0
      end
  end

end
