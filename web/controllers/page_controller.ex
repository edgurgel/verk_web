defmodule VerkWeb.PageController do
  require Verk.QueueStats
  use VerkWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
