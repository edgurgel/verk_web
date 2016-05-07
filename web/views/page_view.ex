defmodule VerkWeb.PageView do
  use VerkWeb.Web, :view

  def stats(queues_stats) do
    Enum.map queues_stats, fn queue_stats ->
      Map.put(queue_stats, :enqueued_counter, Verk.Queue.count!(queue_stats.queue))
    end
  end
end
