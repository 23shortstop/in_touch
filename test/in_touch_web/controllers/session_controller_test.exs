defmodule InTouchWeb.SessionControllerTest do
  use InTouchWeb.ConnCase

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get conn, session_path(conn, :new)
      assert html_response(conn, 200) =~ "Sign In"
    end
  end

  describe "create session" do
    test "redirects to listing users when data is valid", %{conn: conn} do
      user_attrs = %{name: "some name", password: "some_password"}
      insert(:user, user_attrs)

      conn = post conn, session_path(conn, :create), user_attrs

      assert redirected_to(conn) == user_path(conn, :index)

      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end

    test "renders errors when password is invalid", %{conn: conn} do
      user_attrs = %{name: "some name", password: "some_password"}
      invalid_password = user_attrs |> Map.put(:password, "invalid password")
      insert(:user, user_attrs)

      conn = post conn, session_path(conn, :create), invalid_password
      assert html_response(conn, 200) =~ "Sign In"
    end

    test "renders errors when name is invalid", %{conn: conn} do
      user_attrs = %{name: "some name", password: "some_password"}
      invalid_name = user_attrs |> Map.put(:name, "invalid name")
      insert(:user, user_attrs)

      conn = post conn, session_path(conn, :create), invalid_name
      assert html_response(conn, 200) =~ "Sign In"
    end
  end

  describe "delete session" do
    setup [:log_in]

    test "deletes chosen session", %{conn: conn} do
      conn = delete(conn, session_path(conn, :delete))
      assert redirected_to(conn) == session_path(conn, :new)

      conn = get conn, user_path(conn, :index)
      assert redirected_to(conn) == session_path(conn, :new)
    end
  end
end
