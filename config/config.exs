
use Mix.Config


config :tesla, adapter: Tesla.Adapter.Gun

config :teppelin_bot,
			  twitch_base_url: "https://api.twitch.tv/helix",
			  twitch_client_id: "abs86odnei2hcd74p2h0ffy4vt855s"


import_config "#{Mix.env}.exs"
import_config "secret.config.exs"