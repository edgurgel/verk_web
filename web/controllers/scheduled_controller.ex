defmodule VerkWeb.ScheduledController do
  use VerkWeb.Web, :controller

  @schedule_key "schedule"

  def index(conn, params) do
    paginator = VerkWeb.RangePaginator.new(Verk.SortedSet.count!(@schedule_key, Verk.Redis), params["page"], params["per_page"])

    render conn, "index.html",
      queue: @schedule_key,
      scheduled_jobs: Verk.SortedSet.range_with_score!(@schedule_key, paginator.from, paginator.to, Verk.Redis),
      has_next: paginator.has_next,
      has_prev: paginator.has_prev,
      page: paginator.page,
      per_page: paginator.per_page
  end
end
