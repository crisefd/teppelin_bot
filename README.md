# TeppelinBot

**A Telegram Bot written in Elixir to connects with Twitch API**

This bot was implemented using [ex_gram](https://github.com/rockneurotiko/ex_gram/)

It connects to both [Telegram Bot API](https://core.telegram.org/bots/api) and [Twitch TV API](https://dev.twitch.tv/docs/api)

## Installation & Execution

You need to provide a `config/secret.config.exs` file with the following information:

```shell
use Mix.Config

config :teppelin_bot,
		token: "BOT_TOKEN",
		twitch_client_id: "TWITCH_CLIENT_ID"
```

`mix deps.get && mix deps.compile && mix run --no-halt`

## Usage

The bot provides the following commands:

```shell
/start
```
To start the bot

```shell
/get_top_games <number of results>
```
To get the top games (by # of viewers) in Twitch

```shell
/get_top_streams <number of results>
```
To get the top live streams (by # of viewers) in Twitch




Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/teppelin_bot](https://hexdocs.pm/teppelin_bot).

