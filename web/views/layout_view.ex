defmodule VerkWeb.LayoutView do
  use VerkWeb.Web, :view

  def menu_item(conn, path, item) do
    class = if path == conn.request_path, do: "active", else: ""
    content_tag(:li, link(item, to: path), class: class)
  end

  def retries_count do
    count = Verk.RetrySet.count
    ["Retries ", content_tag(:span, to_string(count), class: "badge")]
  end

  def total_stats do
    total_stats = Verk.Stats.total
    processed = [content_tag(:strong, "Processed: "), to_string(total_stats.processed)]
    failed    = [content_tag(:strong, "Failed: "), to_string(total_stats.failed)]
    content_tag :ul, class: "list-inline" do
      [content_tag(:li, processed), content_tag(:li, failed)]
    end
  end
end
