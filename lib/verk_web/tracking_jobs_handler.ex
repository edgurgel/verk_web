defmodule VerkWeb.TrackingJobsHandler do
  use GenEvent
  @broadcast_interval 1_000

  def init(_) do
    Process.send_after(self, :broadcast_stats, @broadcast_interval)
    {:ok, %{finished: 0, failed: 0}}
  end

  def current_stats do
    GenEvent.call(Verk.EventManager, VerkWeb.TrackingJobsHandler, :current_stats)
  end

  def handle_call(:current_stats, state) do
    {:ok, state, state}
  end

  def handle_event(%Verk.Events.JobFinished{}, state) do
    { :ok, %{ finished: state[:finished] + 1, failed: state[:failed] } }
  end
  def handle_event(%Verk.Events.JobFailed{}, state) do
    { :ok, %{ finished: state[:finished] , failed: state[:failed] + 1 } }
  end
  def handle_event(_, state) do
    { :ok, state }
  end

  def handle_info(:broadcast_stats, state) do
    VerkWeb.Endpoint.broadcast("rooms:jobs", "job:stats", state)
    Process.send_after(self, :broadcast_stats, @broadcast_interval)
    {:ok, %{finished: 0, failed: 0}}
  end
  def handle_info(_, state) do
    {:ok, state}
  end
end
