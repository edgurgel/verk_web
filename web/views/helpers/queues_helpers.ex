defmodule VerkWeb.Queue.Helpers do
  import Phoenix.HTML.Link
  import VerkWeb.Router.Helpers

  def pause_button(conn, queue, :paused) do
     button "Resume", to: queues_path(conn, :resume, queue), class: "btn btn-sm"
  end
  def pause_button(_conn, _queue, :pausing), do: "Pausing..."
  def pause_button(conn, queue, _), do: button "Pause", to: queues_path(conn, :pause, queue), class: "btn btn-sm"
end
