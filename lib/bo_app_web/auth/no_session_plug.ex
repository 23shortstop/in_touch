defmodule BoAppWeb.NoSessionPlug do
  import Phoenix.Controller
  import Plug.Conn
  alias BoAppWeb.Router.Helpers, as: Routes
  alias BoAppWeb.AuthToken
  alias BoApp.Chat.User

  def init(opts), do: opts

  def call(conn, _opts) do
    with token <- get_session(conn, :auth_token),
         {:ok, user_id} <- BoAppWeb.AuthToken.verify(token),
         _user <- BoApp.Repo.get(User, user_id) do
          conn |> redirect(to: Routes.user_path(conn, :index)) |> halt
         else
          _ -> conn
         end
  end
end
