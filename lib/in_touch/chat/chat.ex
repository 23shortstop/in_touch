defmodule InTouch.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [put_change: 3]
  alias InTouch.Repo

  alias InTouch.Chat.User
  alias Comeonin.Bcrypt

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id) do
    Repo.fetch(User, id)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    changeset = %User{} |> User.changeset(attrs)
    changeset
    |> put_change(:encrypted_password,
                  Bcrypt.hashpwsalt(changeset.params["password"]))
    |> Repo.insert()
  end
end
