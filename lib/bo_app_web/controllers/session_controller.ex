defmodule BoAppWeb.SessionController do
  use BoAppWeb, :controller

  alias BoApp.Chat
  alias BoApp.Chat.User
  alias Comeonin.Bcrypt
  alias BoAppWeb.AuthToken

  def new(conn, _params) do
    changeset = Chat.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"name" => name, "password" => password}}) do
    {:ok, user} = BoApp.Repo.get_by(User, name: name)
                  |> Bcrypt.check_pass(password)
    token = AuthToken.sign(user)
    put_session(conn, :auth_token, token)
    |> redirect(to: user_path(conn, :index))
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: session_path(conn, :new))
  end
end
