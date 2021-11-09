defmodule VerkWeb.TrackingJobsHandler do
  @moduledoc """
  Responsible for tracking jobs.
  """

  @broadcast_interval 1_000

  use GenStage

  def start_link(pid) do
    GenStage.start_link(__MODULE__, pid)
  end

  def init(pid) do
    Process.send_after(self(), :broadcast_stats, @broadcast_interval)
    {:consumer, {pid, %{finished: 0, failed: 0}}, subscribe_to: [Verk.EventProducer]}
  end

  def handle_events(events, _from, {pid, stats}) do
    stats = Enum.reduce(events, stats, &handle_event(&1, &2))
    {:noreply, [], {pid, stats}}
  end

  defp handle_event(%Verk.Events.JobFinished{}, stats) do
    %{finished: stats[:finished] + 1, failed: stats[:failed]}
  end

  defp handle_event(%Verk.Events.JobFailed{}, stats) do
    %{finished: stats[:finished], failed: stats[:failed] + 1}
  end

  defp handle_event(_, stats), do: stats

  def handle_info(:broadcast_stats, {pid, stats}) do
    send(pid, {:stats, stats})
    Process.send_after(self(), :broadcast_stats, @broadcast_interval)
    {:noreply, [], {pid, %{finished: 0, failed: 0}}}
  end

  def handle_info(_, state), do: {:noreply, [], state}
end
