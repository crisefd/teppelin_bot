
use Mix.Config

# config :ex_gram, adapter: ExGram.Adapter.Maxwell
# config :maxwell, default_adapter: Maxwell.Adapter.Hackney

config :teppelin_bot,
			  twitch_base_url: "https://api.twitch.tv/helix",
			  twitch_client_id: "3arfvc5f6s5s8j1k07rlvoo3a1q3h7"

import_config "secret.config.exs"