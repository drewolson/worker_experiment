defmodule WorkerExperiment.WorkerTest do
  use WorkerExperiment.RepoCase

  test "this works but often logs errors" do
    {:ok, _pid} = start_supervised(WorkerExperiment.Worker)

    Process.sleep(:timer.seconds(1))

    assert 1 == 1
  end
end
