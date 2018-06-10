defmodule InTouch.Identification.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :name, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> encrypt_password
    |> unique_constraint(:name)
  end

  defp encrypt_password(changeset) do
    case fetch_change(changeset, :password) do
      {:ok, password} -> put_change(changeset, :encrypted_password,
                                    Bcrypt.hashpwsalt(password))
                         |> delete_change(:password)
      _ -> changeset
    end
  end
end
