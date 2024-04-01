defmodule Workers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp poolboy_config do
    [
      {:name, :worker_pool},
      {:worker_module, Workers.Worker},
      {:size, 3},
      {:max_overflow, 2}
    ]
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Workers.Worker.start_link(arg)
      # {Workers.Worker, arg}
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PoolboyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
