defmodule BoAppWeb.UserController do
  use BoAppWeb, :controller

  alias BoApp.Chat
  alias BoApp.Chat.User

  def index(conn, _params) do
    users = Chat.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Chat.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Chat.create_user(user_params) do
      {:ok, user} ->
        token = Phoenix.Token.sign(BoAppWeb.Endpoint, "user salt", user.id)
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:auth_token, token)
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Chat.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Chat.get_user!(id)
    changeset = Chat.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Chat.get_user!(id)

    case Chat.update_user(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Chat.get_user!(id)
    {:ok, _user} = Chat.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
