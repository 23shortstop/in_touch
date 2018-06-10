defmodule InTouchWeb.SessionPlugTest do
  use InTouchWeb.ConnCase

  alias InTouch.Identification
  alias InTouchWeb.Session
  import Plug.Test

  test "user is redirected when current_user is not set" do
    conn = build_conn() |> init_test_session(%{}) |> require_login

    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "user passes through when current_user is set" do
    conn = build_conn() |> init_test_session(%{}) |> authenticate |> require_login

    assert not_redirected?(conn)
  end

  defp require_login(conn) do
    conn |> InTouchWeb.SessionPlug.call(%{})
  end

  defp authenticate(conn) do
    {:ok, user} = %{name: "some name", password: "some password"}
                  |> Identification.create_user
    conn |> Session.log_in(user)
  end

  defp not_redirected?(conn) do
    conn.status != 302
  end
end
