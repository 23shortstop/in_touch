defmodule InTouchWeb.UserControllerTest do
  use InTouchWeb.ConnCase

  describe "index" do
    setup [:log_in]

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
      create_attrs = %{name: "some name", password: "some password"}
      conn = post conn, user_path(conn, :create), user: create_attrs

      assert redirected_to(conn) == user_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      invalid_attrs = %{name: nil, password: nil}

      conn = post conn, user_path(conn, :create), user: invalid_attrs
      assert html_response(conn, 200) =~ "Sign Up"
    end
  end
end
