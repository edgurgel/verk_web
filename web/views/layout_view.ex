defmodule VerkWeb.LayoutView do
  use VerkWeb.Web, :view

  def mount_static_path(conn, path) do
    static_path(conn, "#{conn.assigns[:mount_path]}#{path}")
  end

  def menu_item(conn, path, item) do
    class = if path == conn.request_path, do: "active", else: ""
    content_tag(:li, link(item, to: path), class: class)
  end
end
