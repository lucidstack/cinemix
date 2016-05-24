defmodule Cinemix.Mixer do
  import Logger

  def mix(plots) when is_list(plots) do
    mix(plots |> Enum.join(" "))
  end

  def mix(plot) when is_binary(plot) do
    tmp_path = "/tmp/cinemix_#{:rand.uniform(1000)}"

    File.write(tmp_path, plot)
    mixed = case System.cmd("marky_markov", ["speak", "-s", tmp_path, "-c", "8"]) do
      {mixed, 0} ->
        mixed
      {_,  code} ->
        warn("code #{code} from marky. tmp_path is #{tmp_path}")
        ""
    end

    File.rm(tmp_path)
    mixed
  end
end
