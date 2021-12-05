defmodule VerkWeb.Mount do
  @moduledoc false

  defmacro __using__(path: path) do
    quote bind_quoted: [path: path] do
      path = if String.starts_with?(path, "/"), do: path, else: "/" <> path

      socket("#{path}/socket", VerkWeb.UserSocket)
    end
  end
end
