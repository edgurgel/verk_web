defmodule VerkWeb.DashboardController do
  use VerkWeb.Web, :controller

  def show(conn, %{ "queue" => queue }) do
    render conn, "show.html", queue: queue
  end
end
