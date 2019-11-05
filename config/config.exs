
use Mix.Config


config :tesla, adapter: Tesla.Adapter.Gun

config :teppelin_bot,
			  twitch_base_url: "https://api.twitch.tv/helix"


import_config "#{Mix.env}.exs"
import_config "secret.config.exs"