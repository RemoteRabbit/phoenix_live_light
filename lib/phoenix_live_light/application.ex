defmodule PhoenixLiveLight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixLiveLightWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:phoenix_live_light, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixLiveLight.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixLiveLight.Finch},
      # Start a worker by calling: PhoenixLiveLight.Worker.start_link(arg)
      # {PhoenixLiveLight.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixLiveLightWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixLiveLight.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixLiveLightWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
