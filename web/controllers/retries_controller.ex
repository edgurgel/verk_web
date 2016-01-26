defmodule VerkWeb.RetriesController do
  use VerkWeb.Web, :controller

  require Logger

  def index(conn, params) do
    paginator = VerkWeb.RetrySetPaginator.new(Verk.RetrySet.count, params["page"], params["per_page"])

    render conn, "index.html",
      failed_jobs: Verk.RetrySet.range(paginator.from, paginator.to),
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      page: paginator.page,
      per_page: paginator.per_page,
      from: paginator.from,
      to: paginator.to
  end

  def destroy(conn, %{ "jobs_to_remove" => jobs_to_remove }) do
    jobs_to_remove = jobs_to_remove || []

    for job <- jobs_to_remove, do: Verk.RetrySet.delete_job(job)

    redirect conn, to: retries_path(conn, :index)
  end
  def destroy(conn, _params) do
    Verk.RetrySet.clear

    redirect conn, to: retries_path(conn, :index)
  end
end
