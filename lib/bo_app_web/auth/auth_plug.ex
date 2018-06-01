defmodule BoAppWeb.AuthPlug do
  import Phoenix.Controller
  import Plug.Conn
  alias Phoenix.Token
  alias BoApp.Chat.User

  def init(opts), do: opts

  def call(conn, _opts) do
    with token <- get_session(conn, :auth_token),
         {:ok, user_id} <- Phoenix.Token.verify(BoAppWeb.Endpoint, "user salt", token, max_age: 86400),
         user <- BoApp.Repo.get(User, user_id) do
           assign(conn, :current_user, user)
         else
          _ ->
            conn |> redirect(to: "/chat/sessions/new") |> halt
         end
  end
end
