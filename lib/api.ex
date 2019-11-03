defmodule TeppelinBot.Api do 
	use Tesla

	defp host, do: "localhost"
	defp port, do: "4000"

	plug(Tesla.Middleware.BaseUrl, "http://#{host()}:#{port()}")
  plug(Tesla.Middleware.Headers, [{"Content-Type", "application/json"}])
  plug(Tesla.Middleware.JSON)

	require Logger

	def foo do
		{:ok, "Hello world"}
	end
	
end


