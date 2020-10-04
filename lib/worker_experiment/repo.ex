defmodule WorkerExperiment.Repo do
  use Ecto.Repo,
    otp_app: :worker_experiment,
    adapter: Ecto.Adapters.Postgres
end
