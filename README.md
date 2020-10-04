# WorkerExperiment

## Setup

```
docker-compose up -d
mix deps.get
mix test
```

## Help?

How do I make this work?

Here's the output I occasionally see from `mix test`:

```
$ mix test test/worker_experiment/worker_test.exs:7
.

Finished in 5.0 seconds
1 test, 0 failures

Randomized with seed 703489

15:26:00.126 [error] Postgrex.Protocol (#PID<0.225.0>) disconnected: ** (DBConnection.ConnectionError) owner #PID<0.259.0> exited
```

If I add a sleep to the `HttpStream` loop, it seems to fix the problem, but I'm
not sure why.
