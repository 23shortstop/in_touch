defmodule InTouchWeb.UserController do
  use InTouchWeb, :controller

  alias InTouch.Identification
  alias InTouch.Identification.User
  alias InTouchWeb.Session

  def index(conn, _params) do
    users = Identification.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Identification.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> Session.log_in(user)
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
