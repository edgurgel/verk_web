defmodule VerkWeb.DeadController do
  use VerkWeb.Web, :controller
  alias Verk.DeadSet

  require Logger

  def index(conn, params) do
    paginator = VerkWeb.RangePaginator.new(DeadSet.count!(), params["page"], params["per_page"])

    render(conn, "index.html",
      dead_jobs: DeadSet.range!(paginator.from, paginator.to),
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      page: paginator.page,
      per_page: paginator.per_page
    )
  end

  def destroy(conn, %{"jobs_to_remove" => jobs_to_remove}) do
    jobs_to_remove = jobs_to_remove || []

    for job <- jobs_to_remove, do: DeadSet.delete_job!(job)

    redirect(conn, to: dead_path(conn, :index))
  end

  def destroy(conn, _params) do
    DeadSet.clear!()

    redirect(conn, to: dead_path(conn, :index))
  end
end
