defmodule VerkWeb.QueuesController do
  use VerkWeb.Web, :controller

  def show(conn, %{ "queue" => queue }) do
    params = conn.params
    paginator = VerkWeb.RangePaginator.new(Verk.Queue.count(queue), params["page"], params["per_page"])

    render conn, "show.html",
      queue: queue,
      enqueued_jobs: Verk.Queue.range(queue, paginator.from, paginator.to),
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      page: paginator.page,
      per_page: paginator.per_page
  end

  def busy(conn, %{ "queue" => queue }) do
    running_jobs = Verk.WorkersManager.running_jobs(queue)
    render conn, "busy.html", queue: queue, running_jobs: running_jobs
  end
end
