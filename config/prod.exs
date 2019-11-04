use Mix.Config

config :logger, level: :info

config :gen_tcp_accept_and_close, port: 4000
config :gen_tcp_accept_and_close, ip: {0, 0, 0, 0}
