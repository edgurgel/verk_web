defmodule VerkWeb.Plug.Mount do
  @moduledoc false

  import Plug.Conn

  def init(default), do: default

  def call(conn, path), do: call(conn, path, matches?(conn, path))
  def call(conn, path, true), do: process(conn, path)
  def call(conn, _path, false), do: conn

  def process(conn, path) do
    conn
    |> assign(:mount_path, path)
  end

  defp matches?(conn, path) do
    String.starts_with?(conn.request_path, path)
  end
end
