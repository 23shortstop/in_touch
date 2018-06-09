defmodule BoApp.Chat.Session do
  import Phoenix.Controller
  import Plug.Conn
  alias BoAppWeb.Token
  alias BoAppWeb.Router.Helpers, as: Routes

  @doc """
  Creates authentication token, puts it to a session and redirects to a base
  application path
  """
  def log_in(conn, user) do
    token = Token.sign(user)
    put_session(conn, :auth_token, token)
    |> redirect(to: Routes.user_path(conn, :index))
  end

  @doc """
  Fetches a current user based on the session.
  Returns {:ok, user} if the user was fetched successfully,
  or {:error, :unauthorized} otherwise
  """
  def current_user(conn) do
    with token when not is_nil(token) <- get_session(conn, :auth_token),
         {:ok, user_id} <- Token.verify(token),
         {:ok, user} <- BoApp.Chat.get_user(user_id) do
           {:ok, user}
         else
          _ -> {:error, :unauthorized}
         end
  end
end
