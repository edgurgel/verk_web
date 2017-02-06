defmodule VerkWeb.ScheduledController do
  use VerkWeb.Web, :controller
  alias Verk.{SortedSet, Redis}

  @schedule_key "schedule"

  def index(conn, params) do
    paginator = VerkWeb.RangePaginator.new(SortedSet.count!(@schedule_key, Redis), params["page"], params["per_page"])

    render conn, "index.html",
      queue: @schedule_key,
      scheduled_jobs: SortedSet.range_with_score!(@schedule_key, paginator.from, paginator.to, Redis),
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      page: paginator.page,
      per_page: paginator.per_page
  end

  def destroy(conn, %{ "jobs_to_remove" => jobs_to_remove }) do
    jobs_to_remove = jobs_to_remove || []

    for job <- jobs_to_remove, do: SortedSet.delete_job!(@schedule_key, job, Redis)

    redirect conn, to: scheduled_path(conn, :index)
  end
  def destroy(conn, _params) do
    Verk.SortedSet.clear!(@schedule_key, Verk.Redis)

    redirect conn, to: scheduled_path(conn, :index)
  end
end
