defmodule WorkerExperiment.Worker do
  use GenServer

  def start_link(_args, opts \\ []) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @impl GenServer
  def init(_) do
    Process.flag(:trap_exit, true)

    {:ok, nil, {:continue, :start_stream}}
  end

  @impl GenServer
  def handle_continue(:start_stream, _) do
    task = Task.async(__MODULE__, :stream, [self()])

    {:noreply, task}
  end

  @impl GenServer
  def terminate(_reason, task) do
    Task.shutdown(task)

    :ok
  end

  @impl GenServer
  def handle_info({:process_message, _}, task) do
    WorkerExperiment.Repo.transaction(fn ->
      Ecto.Adapters.SQL.query(WorkerExperiment.Repo, "select 1")
    end)

    {:noreply, task}
  end

  def stream(pid) do
    WorkerExperiment.HttpStream.stream(0, fn i, acc ->
      send(pid, {:process_message, i})
      acc + i
    end)
  end
end
