defmodule InTouchWeb.Session do
  import Plug.Conn
  alias InTouch.Identification.AuthToken

  @doc """
  Creates authentication token and puts it to a session.
  """
  def log_in(conn, user) do
    token = AuthToken.sign(user)
    put_session(conn, :auth_token, token)
  end

  @doc """
  Fetches a current user based on the session.
  Returns {:ok, user} if the user was fetched successfully,
  or {:error, :unauthorized} otherwise
  """
  def current_user(conn) do
    with token when not is_nil(token) <- get_session(conn, :auth_token),
         {:ok, user_id} <- AuthToken.verify(token),
         {:ok, user} <- InTouch.Identification.get_user(user_id) do
           {:ok, user}
         else
          _ -> {:error, :unauthorized}
         end
  end
end
