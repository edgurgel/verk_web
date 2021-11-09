defmodule VerkWeb.MountRoute do
  @moduledoc false

  defmacro __using__(path: path) do
    quote bind_quoted: [path: path] do
      path = if String.starts_with?(path, "/"), do: path, else: "/" <> path

      pipeline :verk_web do
        plug(VerkWeb.Plug.Mount, path)
      end

      scope "/" do
        pipe_through(:verk_web)

        forward(path, VerkWeb.Endpoint)
      end
    end
  end
end
