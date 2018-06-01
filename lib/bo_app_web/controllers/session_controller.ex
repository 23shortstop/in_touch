defmodule BoAppWeb.SessionController do
  use BoAppWeb, :controller

  alias BoApp.Chat
  alias BoApp.Chat.User

  def new(conn, _params) do
    changeset = Chat.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"name" => name, "password" => password}}) do
    user = BoApp.Repo.get_by(User, name: name, password: password)
    token = Phoenix.Token.sign(BoAppWeb.Endpoint, "user salt", user.id)
    put_session(conn, :auth_token, token)
    |> redirect to: "/chat/users"
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: session_path(conn, :new))
  end
end
