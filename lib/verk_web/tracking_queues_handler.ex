defmodule VerkWeb.TrackingQueuesHandler do
  use GenStage

  def start_link(pid) do
    GenStage.start_link(__MODULE__, pid)
  end

  def init(pid) do
    {:consumer, pid, subscribe_to: [Verk.EventProducer]}
  end

  def handle_events(events, _from, pid) do
    Enum.each(events, fn event -> handle_event(event, pid) end)
    {:noreply, [], pid}
  end

  defp handle_event(%Verk.Events.QueueRunning{} = event, pid) do
    send pid, {:queue_status, %{queue: event.queue, status: "running"}}
  end
  defp handle_event(%Verk.Events.QueuePausing{} = event, pid) do
    send pid, {:queue_status, %{queue: event.queue, status: "pausing"}}
  end
  defp handle_event(%Verk.Events.QueuePaused{} = event, pid) do
    send pid, {:queue_status, %{queue: event.queue, status: "paused"}}
  end
  defp handle_event(_, _), do: :ok
end
