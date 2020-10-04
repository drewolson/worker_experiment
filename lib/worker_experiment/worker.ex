defmodule WorkerExperiment.Worker do
  use GenServer

  def start_link(_args, opts \\ []) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @impl GenServer
  def init(_) do
    {:ok, :running, {:continue, :start_stream}}
  end

  @impl GenServer
  def handle_continue(:start_stream, state) do
    Task.start_link(__MODULE__, :stream, [self()])

    {:noreply, state}
  end

  @impl GenServer
  def handle_call(:stop, _from, _state), do: {:reply, :ok, :stopped}

  @impl GenServer
  def handle_info({:process_message, _}, :stopped), do: {:noreply, :stopped}

  def handle_info({:process_message, _}, :running) do
    WorkerExperiment.Repo.transaction(fn ->
      Ecto.Adapters.SQL.query(WorkerExperiment.Repo, "select 1")
    end)

    {:noreply, :running}
  end

  def stream(pid) do
    WorkerExperiment.HttpStream.stream(0, fn i, acc ->
      send(pid, {:process_message, i})
      acc + i
    end)
  end
end
