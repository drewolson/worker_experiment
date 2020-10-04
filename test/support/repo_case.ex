defmodule WorkerExperiment.RepoCase do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WorkerExperiment.Repo)

    Ecto.Adapters.SQL.Sandbox.mode(WorkerExperiment.Repo, {:shared, self()})

    :ok
  end
end
