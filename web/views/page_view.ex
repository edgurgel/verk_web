defmodule VerkWeb.PageView do
  use VerkWeb.Web, :view

  def stats(queues_stats) do
    Enum.map queues_stats, fn queue_stats ->
      Map.put(queue_stats, :enqueued_counter, Verk.Queue.count!(queue_stats.queue))
      |> Map.merge(Verk.Stats.queue_total(queue_stats.queue))
    end
  end

  def total_processed do
    Verk.Stats.total.processed
  end

  def total_failed do
    Verk.Stats.total.failed
  end

  def retries_count do
    Verk.RetrySet.count!
  end

  def dead_count do
    Verk.DeadSet.count!
  end
end
