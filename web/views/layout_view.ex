defmodule VerkWeb.LayoutView do
  use VerkWeb.Web, :view

  def menu_item(conn, path, item) do
    class = if path == conn.request_path, do: "active", else: ""
    content_tag(:li, link(item, to: path), class: class)
  end

  def retries_count do
    Verk.RetrySet.count
  end
end
