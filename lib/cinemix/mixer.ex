defmodule Cinemix.Mixer do
  def mix(plots) when is_list(plots) do
    mix(plots |> Enum.join(" "))
  end

  def mix(plot) when is_binary(plot) do
    tmp_path = "/tmp/cinemix_#{:rand.uniform(1000)}"

    File.write(tmp_path, plot)
    {mixed, 0} = System.cmd("marky_markov",
                       ["speak", "-s", tmp_path, "-c", "8"])

    File.rm(tmp_path)
    mixed
  end
end
