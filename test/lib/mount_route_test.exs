defmodule VerkWeb.MountRouteTest do
  use ExUnit.Case, async: true
  alias VerkWeb.MountRoute

  defmodule TestRouter do
    use Phoenix.Router
    use MountRoute, path: "/verk_web"
  end

  def call(router, method, path) do
    method
    |> Plug.Test.conn(path, nil)
    |> router.call(router.init([]))
  end

  test "correctly forwards requests to VerkWeb.Endpoint" do
    conn = call(TestRouter, :get, "/verk_web")
    assert conn.status == 200
    assert conn.private.phoenix_endpoint == VerkWeb.Endpoint
  end

  test "has mount_path in assigns" do
    conn = call(TestRouter, :get, "/verk_web")
    assert conn.assigns[:mount_path] == "/verk_web"
  end
end
