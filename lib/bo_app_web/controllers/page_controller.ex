defmodule BoAppWeb.PageController do
  use BoAppWeb, :controller

  def index(conn, _params) do
    redirect conn, to: session_path(conn, :new)
  end
end
