defmodule TeppelinBotTest do
  use ExUnit.Case
  doctest TeppelinBot

  test "greets the world" do
    assert TeppelinBot.hello() == :world
  end
end
