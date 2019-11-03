defmodule TeppelinBot.Bot do
  @bot :teppelin_bot
		
  use ExGram.Bot, name: @bot

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, "start", _msg}, context) do
    answer(context, "Hi! I'm Teppelin Bot")
  end
end
