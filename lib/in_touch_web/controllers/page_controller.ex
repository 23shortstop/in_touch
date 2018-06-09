defmodule InTouchWeb.PageController do
  use InTouchWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: user_path(conn, :index))
  end
end
