defmodule VerkWeb.RoomChannel do
  use Phoenix.Channel
  alias VerkWeb.TrackingJobsHandler
  alias VerkWeb.TrackingQueuesHandler

  @doc false
  def join("rooms:jobs", _, socket) do
    {:ok, _pid} = TrackingJobsHandler.start_link(self)
    {:ok, socket}
  end

  @doc false
  def join("rooms:queues", _, socket) do
    {:ok, _pid} = TrackingQueuesHandler.start_link(self)
    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:stats, stats}, socket) do
    push socket, "job:stats", stats
    {:noreply, socket}
  end

  def handle_info({:queue_status, msg}, socket) do
    push socket, "queue:status", msg
    {:noreply, socket}
  end

  def terminate(_reason, _socket), do: :ok
end
