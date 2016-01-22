defmodule VerkWeb.PageControllerTest do
  use VerkWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "No job was started yet."
  end
end
