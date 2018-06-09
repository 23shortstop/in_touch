defmodule BoAppWeb.UserController do
  use BoAppWeb, :controller

  alias BoApp.Chat
  alias BoApp.Chat.User
  alias BoApp.Chat.Session

  def index(conn, _params) do
    users = Chat.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Chat.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> Session.log_in(user)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
