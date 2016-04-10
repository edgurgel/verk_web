defmodule VerkWeb.SharedView do
  use VerkWeb.Web, :view

  def enqueued_at(nil), do: "N/A"
  def enqueued_at(timestamp) do
    timestamp |> Timex.DateTime.from_seconds |> Timex.format!("{ISO}")
  end
end
