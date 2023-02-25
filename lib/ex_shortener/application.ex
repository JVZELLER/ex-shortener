defmodule ExShortener.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExShortenerWeb.Telemetry,
      # Start the Ecto repository
      ExShortener.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExShortener.PubSub},
      # Start the Endpoint (http/https)
      ExShortenerWeb.Endpoint
      # Start a worker by calling: ExShortener.Worker.start_link(arg)
      # {ExShortener.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExShortener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExShortenerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
