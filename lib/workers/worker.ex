defmodule Workers.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:process_work, x}, _from, state) do
    IO.puts("Doing work for #{inspect(self())} #{x}")

    {:reply, result, state}
  end
end
