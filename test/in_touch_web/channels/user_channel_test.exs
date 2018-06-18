defmodule InTouchWeb.UserChannelTest do
  use InTouchWeb.ChannelCase

  alias InTouchWeb.UserChannel
  alias InTouch.Identification

  @user_attrs %{name: "some name", password: "some password"}

  def fixture(:user) do
    {:ok, user} = Identification.create_user(@user_attrs)
    user
  end

  setup do
    user = fixture(:user)
    {:ok, _, socket} =
      socket("user_sosket:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(UserChannel, "user:#{user.id}")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
