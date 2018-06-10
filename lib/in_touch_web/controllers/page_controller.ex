defmodule InTouchWeb.PageController do
  use InTouchWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
