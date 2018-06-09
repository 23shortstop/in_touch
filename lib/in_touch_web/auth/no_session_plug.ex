defmodule InTouchWeb.NoSessionPlug do
  import Phoenix.Controller
  import Plug.Conn
  alias InTouchWeb.Session

  def init(opts), do: opts

  @doc """
  Redirects to the base app path if a user already has a session
  """
  def call(conn, _opts) do
    case Session.current_user(conn) do
      {:ok, _user} -> conn |> redirect(to: "/") |> halt
      _unauthorized -> conn
    end
  end
end
