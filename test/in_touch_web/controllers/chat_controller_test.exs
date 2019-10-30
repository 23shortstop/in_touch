defmodule InTouchWeb.ChatControllerTest do
  use InTouchWeb.ConnCase

  describe "index" do
    setup [:log_in]

    test "lists users chats", %{conn: conn} do
      conn = get conn, chat_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Chats"
    end
  end

  describe "show" do
    setup [:log_in]

    test "shows chat by id", %{conn: conn} do
      chat = insert(:chat)

      conn = get conn, chat_path(conn, :show, chat.id)
      assert html_response(conn, 200) =~ "Show Chat"
    end
  end

  describe "create chat" do
    setup [:log_in]

    test "redirects to show when data is valid", %{conn: conn} do
      create_attrs = %{participant_ids: [], type: "direct"}

      conn = post conn, chat_path(conn, :create), chat: create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == chat_path(conn, :show, id)

      conn = get conn, chat_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Chat"
    end
  end
end
