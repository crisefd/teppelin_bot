defmodule TeppelinBot do
  use Application
  require Logger

  @bot_token Application.get_env(:teppelin_bot, :token)


  def start(_type, _args) do
    children = [
       ExGram, 
      {TeppelinBot.Bot, [method: :polling, token: @bot_token]}
    ]

    opts = [strategy: :one_for_one, name: TeppelinBot.Supervisor]

    case Supervisor.start_link(children, opts) do
      {:ok, _ } = ok ->
        Logger.info("Starting TeppelinBot")
        ok
      error ->
        Logger.error("Error starting TeppelinBot")
        error
    end
  end
  
end
