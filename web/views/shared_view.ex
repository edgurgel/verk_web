defmodule VerkWeb.SharedView do
  use VerkWeb.Web, :view

  def enqueued_at(nil), do: "N/A"
  def enqueued_at(timestamp) do
    timestamp |> Timex.Date.from(:secs) |> Timex.DateFormat.format!("{ISO}")
  end
end
