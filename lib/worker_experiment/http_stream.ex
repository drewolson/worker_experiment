defmodule WorkerExperiment.HttpStream do
  def stream(acc, fun) do
    Stream.repeatedly(fn ->
      :rand.uniform(10)
    end)
    |> Enum.reduce(acc, fun)
  end
end
