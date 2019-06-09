defmodule VerkWeb.QueuesView do
  use VerkWeb.Web, :view

  def stats(queues_stats) do
    Enum.map(queues_stats, fn queue_stats ->
      Map.put(queue_stats, :enqueued_counter, Verk.Queue.count!(queue_stats.queue))
      |> Map.merge(Verk.Stats.queue_total(queue_stats.queue))
    end)
  end

  def jobs(jobs) do
    Enum.map(jobs, fn job ->
      %{
        jid: job.jid,
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end)
  end
end
