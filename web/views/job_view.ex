defmodule VerkWeb.JobView do
  use VerkWeb.Web, :view

  def info(process_info, key) do
    Keyword.get(process_info, key)
  end

  def current_stacktrace(process_info) do
    info(process_info, :current_stacktrace)
    |> Exception.format_stacktrace
    |> Phoenix.HTML.Format.text_to_html
  end

  def utc_format(time) do
    time |> Timex.format!("{ISO}")
  end
end
