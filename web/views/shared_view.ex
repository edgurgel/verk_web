defmodule VerkWeb.SharedView do
  use VerkWeb.Web, :view

  def enqueued_at(nil), do: "N/A"
  def enqueued_at(timestamp) do
    timestamp |> round |> Timex.from_unix |> Timex.format!("{relative}", :relative)
  end
end
