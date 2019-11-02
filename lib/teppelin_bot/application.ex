defmodule TeppelinBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @bot_token Application.get_env(:teppelin, :token)

  use Application

  def start(_type, _args) do
    children = [
       ExGram, # This will setup the Registry.ExGram,
      {TeppelinBot.Bot, [method: :polling, token: @bot_token]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TeppelinBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
