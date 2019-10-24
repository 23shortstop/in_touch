defmodule InTouchWeb.ChatView do
  use InTouchWeb, :view

  def title(_conn, chat) do
    case chat.title do
      nil -> InTouch.Repo.preload(chat, :users).users
             |> Enum.map(&(&1.name))
             |> Enum.join(", ")
      title -> title
    end
  end
end
