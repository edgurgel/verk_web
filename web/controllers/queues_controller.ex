defmodule VerkWeb.QueuesController do
  require Verk.WorkersManager

  use VerkWeb.Web, :controller

  def show(conn, %{ "queue" => queue }) do
    running_jobs = Verk.WorkersManager.running_jobs(queue)
    render conn, "show.html", queue: queue, running_jobs: running_jobs
  end
end
