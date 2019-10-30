defmodule InTouch.IdentificationTest do
  use InTouch.DataCase

  alias InTouch.Identification

  describe "users" do
    alias InTouch.Identification.User

    test "list_users/0 returns all users" do
      user = insert(:user)

      assert Identification.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)

      assert {:ok, %User{} = fetched_user} = Identification.get_user(user.id)
      assert user.name == fetched_user.name
      assert user.id == fetched_user.id
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", password: "some password"}

      assert {:ok, %User{} = user} = Identification.create_user(valid_attrs)
      assert user.name == "some name"
      assert {:ok, user} == Comeonin.Bcrypt.check_pass(user, "some password")
    end

    test "create_user/1 with invalid data returns error changeset" do
      invalid_attrs = %{name: nil, password: nil}

      assert {:error, %Ecto.Changeset{}} = Identification.create_user(invalid_attrs)
    end
  end
end
