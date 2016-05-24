defmodule Cinemix.Mixer do
  def mix(plot_1, plot_2) do
    {:ok, model} = ExChain.MarkovModel.start_link
    ExChain.MarkovModel.populate_model(model, plot_1 <> " " <> plot_2)
    model
  end

  def sentence(model) do
    ExChain.SentenceGenerator.create_filtered_sentence(model)
  end
end
