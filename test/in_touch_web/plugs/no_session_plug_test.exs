defmodule InTouchWebo.NoSessionPlugTest do
  use InTouchWeb.ConnCase

  alias InTouch.Identification
  alias InTouchWeb.Session
  import Plug.Test

  test "user is redirected when current_user is set" do
    conn = build_conn() |> init_test_session(%{}) |> require_no_login

    assert not_redirected?(conn)
  end

  test "user passes through when current_user is not set" do
    conn = build_conn() |> init_test_session(%{}) |> authenticate |> require_no_login

    assert redirected_to(conn) == "/"
  end

  defp require_no_login(conn) do
    conn |> InTouchWeb.NoSessionPlug.call(%{})
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
