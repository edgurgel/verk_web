defmodule VerkWeb.QueuesView do
  use VerkWeb.Web, :view

  def stats(queues_stats) do
    Enum.map(queues_stats, fn queue_stats ->
      queue_stats
      |> Map.put(:enqueued_counter, Verk.Queue.count!(queue_stats.queue))
      |> Map.merge(Verk.Stats.queue_total(queue_stats.queue))
    end)
  end

  def enqueued_jobs(jobs) do
    Enum.map(jobs, fn job ->
      %{
        jid: job.jid,
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end)
  end

  def jobs(running_jobs) do
    Enum.map(running_jobs, fn running_job ->
      job = running_job.job

      %{
        jid: job.jid,
        started_at: running_job.started_at |> DateTime.to_string(),
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end)
  end
end
