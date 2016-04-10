defmodule VerkWeb.Mount do
  defmacro __using__(path: path) do
    quote bind_quoted: [path: path] do
      unless String.starts_with?(path, "/"), do: path = "/" <> path
      plug VerkWeb.Plug.Mount, path
      socket "#{path}/socket", VerkWeb.UserSocket
    end
  end
end
