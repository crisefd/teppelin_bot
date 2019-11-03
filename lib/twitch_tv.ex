defmodule TeppelinBot.TwitchTV do
	use GenServer
	require Logger

	@me TwitchTV
	@base_url Application.get_env(:teppelin_bot, :twitch_base_url)
	@client_id Application.get_env(:teppelin, :twitch_client_id)

	def start_link([]) do
		GenServer.start_link(__MODULE__, name: @me)
	end

	def get_top_games(first \\ 10) do
		GenServer.call(@me, {:get_top_games, first})
	end

	# callbacks

	def init(init_arg) do
    {:ok, init_arg}
  end

	def handle_call({:get_top_games, first}, state) do
		full_url = "#{@base_url}/games/top?first=#{first}"
		headers = ["Client-ID": @client_id, "User-Agent": "Teppelin Bot"]
		result = 
			with {:ok, data} <- get(full_url, headers) do
				data 
				|> Enum.with_index()
				|> Enum.map(fn {item, index} -> 
					"#{index + 1} | #{String.slice(item[:name], 0, 20)}"
				end)

				else 
					{:error, error} ->
						Logger.error("error at get_top_games. #{inspect error}")
						:error
			end
		{:reply, result, state}
	end


	defp get(url, headers) do
		HTTPoison.get(url, headers)
		|> handle_response()
	end

	defp handle_response({_, %{status_code: status_code, body: body} }) do
		check_for_errors(status_code, body) 
	end

	defp check_for_errors(200, body), do: body |> parse_data()

	defp check_for_errors(_, body), do: {:error, body}

	defp parse_data(data) do
		data
		|> Poison.decode!(keys: :atoms)
		|> Map.get(:data)
	end
	
	
end
