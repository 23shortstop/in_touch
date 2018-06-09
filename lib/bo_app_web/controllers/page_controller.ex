defmodule BoAppWeb.PageController do
  use BoAppWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: user_path(conn, :index))
  end
end
