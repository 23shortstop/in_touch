defmodule BoAppWeb.AuthPlug do
  import Phoenix.Controller
  alias BoAppWeb.Router.Helpers, as: Routes
  import Plug.Conn
  alias BoAppWeb.AuthToken
  alias BoApp.Chat.User

  def init(opts), do: opts

  def call(conn, _opts) do
    with token <- get_session(conn, :auth_token),
         {:ok, user_id} <- BoAppWeb.AuthToken.verify(token),
         user <- BoApp.Repo.get(User, user_id) do
           assign(conn, :current_user, user)
         else
          _ ->
            conn |> redirect(to: Routes.session_path(conn, :new)) |> halt
         end
  end
end
