defmodule WorkerExperiment.WorkerTest do
  use WorkerExperiment.RepoCase

  test "this works but occasionally logs errors" do
    {:ok, _pid} = start_supervised(WorkerExperiment.Worker)

    Process.sleep(:timer.seconds(1))

    assert 1 == 1
  end

  test "this times out calling `GenServer.call`" do
    {:ok, pid} = start_supervised(WorkerExperiment.Worker)

    Process.sleep(:timer.seconds(1))

    assert 1 == 1

    GenServer.call(pid, :stop)
  end
end
