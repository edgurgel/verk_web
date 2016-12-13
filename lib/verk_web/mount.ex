defmodule VerkWeb.Mount do
  defmacro __using__(path: path) do
    quote bind_quoted: [path: path] do
      path = if String.starts_with?(path, "/"), do: path, else: "/" <> path
      plug VerkWeb.Plug.Mount, path
      socket "#{path}/socket", VerkWeb.UserSocket
    end
  end
end
