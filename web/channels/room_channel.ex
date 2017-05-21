defmodule VerkWeb.RoomChannel do
  use Phoenix.Channel
  alias VerkWeb.TrackingJobsHandler

  @doc false
  def join("rooms:jobs", _, socket) do
    {:ok, _pid} = TrackingJobsHandler.start_link(self)
    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:stats, stats}, socket) do
    push socket, "job:stats", stats
    {:noreply, socket}
  end

  def terminate(_reason, _socket), do: :ok
end
