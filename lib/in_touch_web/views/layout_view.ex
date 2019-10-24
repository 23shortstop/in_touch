defmodule InTouchWeb.LayoutView do
  use InTouchWeb, :view

  def user_token(conn), do: Plug.Conn.get_session(conn, :auth_token)

  def user_id(conn), do: conn.assigns.current_user.id
end
