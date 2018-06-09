defmodule BoAppWeb.SessionController do
  use BoAppWeb, :controller

  alias BoApp.Chat.User
  alias BoApp.Chat.Session
  alias Comeonin.Bcrypt

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn,%{"name" => name, "password" => password}) do
    with {:ok, user} <- BoApp.Repo.fetch_by(User, name: name),
         {:ok, user} <- Bcrypt.check_pass(user, password) do
           Session.log_in(conn, user)
         else
           _ -> conn
                |> put_private(:invalid_credentials, true)
                |> render("new.html")
         end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: session_path(conn, :new))
  end
end
