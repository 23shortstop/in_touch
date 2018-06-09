defmodule BoAppWeb.SessionPlug do
  import Phoenix.Controller
  alias BoAppWeb.Router.Helpers, as: Routes
  import Plug.Conn
  alias BoApp.Chat.Session

  def init(opts), do: opts

  @doc """
  Checks if a user already has a session and redirects to the new session path
  if not so.
  """
  def call(conn, _opts) do
    case Session.current_user(conn) do
      {:ok, user} -> assign(conn, :current_user, user)
      _unauthorized -> conn
                       |> redirect(to: Routes.session_path(conn, :new))
                       |> halt
    end
  end
end
