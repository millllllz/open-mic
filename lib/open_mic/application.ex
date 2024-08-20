defmodule OpenMic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OpenMicWeb.Telemetry,
      OpenMic.Repo,
      {DNSCluster, query: Application.get_env(:open_mic, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OpenMic.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: OpenMic.Finch},
      # Start a worker by calling: OpenMic.Worker.start_link(arg)
      # {OpenMic.Worker, arg},
      # Start to serve requests, typically the last entry
      OpenMicWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OpenMic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OpenMicWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
