defmodule TeppelinBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :teppelin_bot,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TeppelinBot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
     {:ex_gram, "~> 0.8"},
     {:tesla, "~> 1.2"},
     {:hackney, "~> 1.12"},
     {:gun, "~> 1.3"},
     {:jason, "~> 1.1"},
    ]
  end
end
