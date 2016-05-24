defmodule Cinemix.PageController do
  use Cinemix.Web, :controller

  def index(conn, _params) do
    random_films = :code.priv_dir(:cinemix)
    |> Path.join("films/all.csv")
    |> File.stream!
    |> CSV.decode(headers: true)
    |> Enum.take_random(10)
    |> Enum.map(&Map.get(&1, "Film"))

    plots = random_films
    |> Enum.map(&Task.async(fn -> Cinemix.OmdbClient.movie(title: &1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.map(&Map.get(&1, "Plot"))

    mixed = Cinemix.Mixer.mix(plots)
    render conn, "index.html", mixed: mixed, films: random_films
  end
end
