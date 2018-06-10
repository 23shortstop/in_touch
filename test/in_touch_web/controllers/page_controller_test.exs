defmodule InTouchWeb.PageControllerTest do
  use InTouchWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn) == "/sessions/new"
  end
end
