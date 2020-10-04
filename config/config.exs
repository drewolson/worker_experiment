import Config

config :worker_experiment, ecto_repos: [WorkerExperiment.Repo]

config :worker_experiment, WorkerExperiment.Repo,
  database: "worker_experiment_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, :console, level: :warn
