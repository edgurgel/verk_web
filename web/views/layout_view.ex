defmodule VerkWeb.LayoutView do
  use VerkWeb.Web, :view

  def mount_static_path(conn, path) do
    static_path(conn, "#{conn.assigns[:mount_path]}#{path}")
  end

  def menu_item(conn, path, item) do
    class = if path == conn.request_path, do: "active", else: ""
    content_tag(:li, link(item, to: path), class: class)
  end

  # From: https://blog.diacode.com/page-specific-javascript-in-phoenix-framework-pt-1
  @doc """
  Generates name for the JavaScript view we want to use
  in this combination of view/template.
  """
  def js_view_name(conn, view_template) do
    [view_name(conn), template_name(view_template)]
    |> Enum.reverse
    |> Enum.map(&String.capitalize/1)
    |> Enum.reverse
    |> Enum.join("")
  end

  # Takes the resource name of the view module and removes the
  # the ending *_view* string.
  defp view_name(conn) do
    conn
    |> view_module
    |> Phoenix.Naming.resource_name
    |> String.replace("_view", "")
  end

  # Removes the extion from the template and reutrns
  # just the name.
  defp template_name(template) when is_binary(template) do
    template
    |> String.split(".")
    |> Enum.at(0)
  end
end
