defmodule VerkWeb do
  @moduledoc false

  use Application

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {VerkWeb.Endpoint, [type: :supervisor]},

      # pub sub
      {Phoenix.PubSub, [name: VerkWeb.PubSub, adapter: Phoenix.PubSub.PG2]}
    ]

    children =
      if Application.get_env(:verk_web, :link_verk_supervisor, false) do
        [{Verk.Supervisor, [type: :supervisor]} | children]
      else
        children
      end

    :ets.new(:verk_web_session, [:named_table, :public, read_concurrency: true])
    opts = [strategy: :one_for_one, name: VerkWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc false
  def config_change(changed, _new, removed) do
    VerkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
