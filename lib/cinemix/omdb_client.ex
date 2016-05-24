defmodule Cinemix.OmdbClient do
  @omdb_url "http://www.omdbapi.com/"
  def movie(title: title) do
    HTTPoison.get!(@omdb_url, %{}, params: %{t: title, plot: "full"})
    |> Map.get(:body)
    |> Poison.decode!
  end
end
