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
    parseInt = fn txt ->
      try do
        String.to_integer(txt)
      rescue
        _ -> 0
      end
    end

    top_games =
      with val when val >= 1 <- parseInt.(text) do
        TwitchTV.get_top_games(val)
      else
        _ ->
          TwitchTV.get_top_games()
      end

    result =
      case top_games do
        :error -> "Unexpected error 😰"
        _ -> "*Rank|Game*\n#{Enum.join(top_games, "\n")}"
      end

    answer(context, result, parse_mode: "Markdown")
  end
end
