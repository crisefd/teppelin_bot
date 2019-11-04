defmodule TeppelinBot.TwitchTV do
  require Logger

  @base_url Application.get_env(:teppelin_bot, :twitch_base_url)
  @client_id Application.get_env(:teppelin_bot, :twitch_client_id)
  @headers ["Client-ID": @client_id, "User-Agent": "Teppelin Bot"]

  def get_top_games(first \\ 10) do
    full_url = "#{@base_url}/games/top?first=#{first}"
    result =
      with {:ok, data} <- get(full_url, @headers) do
        data
        |> Enum.with_index()
        |> Enum.map(fn {item, index} ->
          n = Integer.to_string(index + 1)
          name = item[:name]
          rank = String.pad_trailing(n, 8 - String.length(n))
          title = process_name(name)
          "#{rank} | #{title}"
        end)
      else
        {:error, error} ->
          Logger.error("error at TeppelinBot.TwitchTV.get_top_games. #{inspect(error)}")
          :error
      end
    result
  end

  def get_top_streams(first \\ 10) do
    full_url = "#{@base_url}/streams?first=#{first}"
    result =
      with {:ok, data} <- get(full_url, @headers) do
          data
          |> Enum.with_index()
          |> Enum.map(fn {item, index} ->
             n = Integer.to_string(index + 1)
             rank = String.pad_trailing(n, 8 - String.length(n))
             name = item[:title]
             url = "https://twitch.tv/#{item[:user_name]}"
             title = process_name(name)
             "#{rank} | [#{title}](#{url})"
          end)
        else
          {:error, error} ->
            Logger.error("error at TeppelinBot.TwitchTV.get_top_streams. #{inspect(error)}")
            :error
      end
    result
  end

  defp process_name(name, limit \\ 18) do
    cond do
      is_nil(name) -> ""
      String.length(name) < limit -> name
      true ->  name |> String.slice(0, limit) |> String.pad_trailing(3, ".")
    end
  end

  defp get(url, headers) do
    HTTPoison.get(url, headers)
    |> handle_response()
  end

  defp handle_response({_, %{status_code: status_code, body: body}}) do
    check_for_errors(status_code, body)
  end

  defp check_for_errors(200, body), do: body |> parse_data()

  defp check_for_errors(_, body), do: {:error, body}

  defp parse_data(data) do
    {:ok,
     data
     |> Poison.decode!(keys: :atoms)
     |> Map.get(:data)}
  end
end
