defmodule VerkWeb.TrackingJobsHandler do
  use GenEvent
  @broadcast_interval 1_000

  def init(pid) do
    Process.send_after(self(), :broadcast_stats, @broadcast_interval)
    {:ok, {pid, %{finished: 0, failed: 0}}}
  end

  def handle_event(%Verk.Events.JobFinished{}, {pid, stats}) do
    { :ok, {pid, %{finished: stats[:finished] + 1, failed: stats[:failed]}} }
  end
  def handle_event(%Verk.Events.JobFailed{}, {pid, stats}) do
    { :ok, {pid, %{finished: stats[:finished], failed: stats[:failed] + 1}} }
  end
  def handle_event(_, state) do
    { :ok, state }
  end

  def handle_info(:broadcast_stats, {pid, stats}) do
    send pid, {:stats, stats}
    Process.send_after(self(), :broadcast_stats, @broadcast_interval)
    {:ok, {pid, %{finished: 0, failed: 0}}}
  end
  def handle_info(_, state) do
    {:ok, state}
  end
end
