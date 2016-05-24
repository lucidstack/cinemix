defmodule Cinemix.PageController do
  use Cinemix.Web, :controller

  def index(conn, _params) do
    random_films = File.stream!("priv/static/films/all.csv")
    |> CSV.decode(headers: true)
    |> Enum.take_random(10)
    |> Enum.map(&Map.get(&1, "Film"))

    plot = random_films
    |> Enum.map(&Task.async(fn -> Cinemix.OmdbClient.movie(title: &1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.map(&Map.get(&1, "Plot"))
    |> Enum.join("")

    mixed = :os.cmd('echo "#{plot}" | marky_markov')
    render conn, "index.html",
      mixed: mixed, films: random_films
  end
end
