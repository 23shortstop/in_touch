defmodule InTouch.IdentificationTest do
  use InTouch.DataCase

  alias InTouch.Identification

  describe "users" do
    alias InTouch.Identification.User

    @valid_attrs %{name: "some name", password: "some password"}
    @invalid_attrs %{name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Identification.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Identification.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Identification.get_user(user.id) == {:ok, user}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Identification.create_user(@valid_attrs)
      assert user.name == "some name"
      assert {:ok, user} == Comeonin.Bcrypt.check_pass(user, "some password")
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Identification.create_user(@invalid_attrs)
    end
  end
end
