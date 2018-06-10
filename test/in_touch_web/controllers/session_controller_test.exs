defmodule InTouchWeb.SessionControllerTest do
  use InTouchWeb.ConnCase

  alias InTouch.Identification

  @user_attrs %{name: "some name", password: "some password"}
  @invalid_password %{name: "some name", password: "invalid password"}
  @invalid_name %{name: "invalid name", password: "some password"}

  def fixture(:user) do
    {:ok, user} = Identification.create_user(@user_attrs)
    user
  end

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get conn, session_path(conn, :new)
      assert html_response(conn, 200) =~ "Sign In"
    end
  end

  describe "create session" do
    setup [:create_user]

    test "redirects to listing users when data is valid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @user_attrs

      assert redirected_to(conn) == user_path(conn, :index)

      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end

    test "renders errors when password is invalid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @invalid_password
      assert html_response(conn, 200) =~ "Sign In"
    end

    test "renders errors when name is invalid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), @invalid_name
      assert html_response(conn, 200) =~ "Sign In"
    end
  end

  describe "delete session" do
    setup [:create_user]

    test "deletes chosen session", %{conn: conn} do
      conn = post(conn, session_path(conn, :create), @user_attrs)
             |> get(user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"

      conn = delete(conn, session_path(conn, :delete))
      assert redirected_to(conn) == session_path(conn, :new)

      conn = get conn, user_path(conn, :index)
      assert redirected_to(conn) == session_path(conn, :new)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
