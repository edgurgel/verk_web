defmodule VerkWeb.RoomChannel do
  use Phoenix.Channel

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic

  Possible Return Values

  `{:ok, socket}` to authorize subscription for channel for requested topic

  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("rooms:jobs", _, socket) do
    Process.flag(:trap_exit, true)
    send self, :stats

    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:stats, socket) do
    push socket, "job:stats", TrackingJobsHandler.current_stats
    {:noreply, socket}
  end

  def terminate(_reason, _socket) do
    :ok
  end
end
