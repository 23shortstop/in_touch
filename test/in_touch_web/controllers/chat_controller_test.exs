defmodule InTouchWeb.ChatControllerTest do
  use InTouchWeb.ConnCase

  alias InTouch.Identification

  @user_attrs %{name: "some name", password: "some password"}
  @create_attrs %{participant_ids: [], type: "direct"}

  def fixture(:user) do
    {:ok, user} = Identification.create_user(@user_attrs)
    user
  end

  describe "index" do
    setup [:create_user, :log_in]

    test "lists users chats", %{conn: conn} do
      conn = get conn, chat_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Chats"
    end
  end

  describe "show" do
    setup [:create_user, :log_in]

    test "shows chat by id", %{conn: conn} do
      conn = get conn, chat_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Chats"
    end
  end

  describe "create chat" do
    setup [:create_user, :log_in]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, chat_path(conn, :create), chat: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == chat_path(conn, :show, id)

      conn = get conn, chat_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Chat"
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp log_in(_) do
    conn = build_conn()
    conn = post(conn, session_path(conn, :create), @user_attrs)
    {:ok, conn: conn}
  end
end
