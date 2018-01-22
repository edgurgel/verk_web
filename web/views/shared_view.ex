defmodule VerkWeb.SharedView do
  use VerkWeb.Web, :view

  def enqueued_at(nil), do: "N/A"
  def enqueued_at(timestamp) do
    timestamp |> round |> Timex.from_unix |> Timex.format!("{relative}", :relative)
  end

  def error_backtrace(nil), do: "N/A"
  def error_backtrace(string) do
    Regex.replace(~r( {2,}), string, "")
  end
end
