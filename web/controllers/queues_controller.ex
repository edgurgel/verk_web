defmodule VerkWeb.QueuesController do
  require Verk.QueueStats
  use VerkWeb.Web, :controller
  alias Verk.Queue

  def index(conn, params) do
    {:ok, queues} = Verk.QueueList.all(params["search"] || "")

    queue_stats =
      Enum.map(queues, fn queue ->
        %{
          queue: queue,
          status: Verk.Manager.status(String.to_existing_atom(queue)),
          enqueued_counter: Queue.count!(queue),
          running_counter: Queue.count_pending!(queue)
        }
        |> Map.merge(Verk.Stats.queue_total(queue))
      end)

    render(conn, "index.html",
      queue_stats: queue_stats,
      search: params["search"]
    )
  end

  def show(conn, %{"queue" => queue}) do
    params = conn.params

    jobs = Queue.range!(queue, params["from"] || "0-0")

    paginator =
      VerkWeb.QueueRangePaginator.new(jobs, params["from"] || "0-0", params["per_page"] || 25)

    render(conn, "show.html",
      queue: queue,
      enqueued_jobs: jobs,
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      from: paginator.from,
      to: paginator.to
    )
  end

  def busy(conn, %{"queue" => queue}) do
    {:ok, running_jobs} = Queue.pending_jobs(queue)
    render(conn, "busy.html", queue: queue, running_jobs: running_jobs)
  end

  def pause(conn, %{"queue" => queue}) do
    queue |> String.to_atom() |> Verk.pause_queue()
    redirect(conn, to: queues_path(conn, :index))
  end

  def resume(conn, %{"queue" => queue}) do
    queue |> String.to_atom() |> Verk.resume_queue()
    redirect(conn, to: queues_path(conn, :index))
  end
end
