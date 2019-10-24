defmodule InTouchWeb.ChatController do
  use InTouchWeb, :controller

  alias InTouch.Messaging

  def index(conn, _params) do
    chats = conn.assigns.current_user |> Messaging.list_chats
    render(conn, "index.html", chats: chats)
  end

  def create(conn, %{"chat" => chat_params}) do
    chat_params
      |> Map.update("participant_ids", [], &(prepare_participant_ids(&1, conn)))
      |> Messaging.create_chat
      |> case do
        {:ok, chat} -> conn |> redirect(to: chat_path(conn, :show, chat))
        _ -> put_flash(conn, :error, "Failed to create chat.")
             |> redirect(to: user_path(conn, :index))
      end
  end

  def show(conn, %{"id" => id}) do
    chat = Messaging.get_chat!(id)
    render(conn, "show.html", chat: chat)
  end

  defp prepare_participant_ids(ptcp_ids, conn) do
    ptcp_ids
      |> Enum.map(&String.to_integer/1)
      |> List.insert_at(0, conn.assigns.current_user.id)
  end
end
