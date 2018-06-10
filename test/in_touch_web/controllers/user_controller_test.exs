defmodule InTouchWeb.UserControllerTest do
  use InTouchWeb.ConnCase

  alias InTouch.Identification

  @create_attrs %{name: "some name", password: "some password"}
  @invalid_attrs %{name: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Identification.create_user(@create_attrs)
    user
  end

  describe "index" do
    setup [:create_user, :log_in]

    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "Sign Up"
    end
  end

  describe "create user" do
    test "redirects to listing users when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs

      assert redirected_to(conn) == user_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Sign Up"
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp log_in(_) do
    conn = build_conn()
    conn = post(conn, session_path(conn, :create), @create_attrs)
    {:ok, conn: conn}
  end
end
