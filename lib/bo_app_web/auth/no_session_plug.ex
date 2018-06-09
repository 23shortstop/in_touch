defmodule BoAppWeb.NoSessionPlug do
  import Phoenix.Controller
  import Plug.Conn
  alias BoApp.Chat.Session

  def init(opts), do: opts

  def call(conn, _opts) do
    case Session.current_user(conn) do
      {:ok, _user} -> conn |> redirect(to: "/") |> halt
      _unauthorized -> conn
    end
  end
end
