defmodule InTouchWeb.UserChannelTest do
  use InTouchWeb.ChannelCase

  alias InTouchWeb.UserChannel

  setup do
    user = insert(:user)
    {:ok, _, socket} =
      socket(InTouchWeb.UserSocket, "user_sosket:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(UserChannel, "user:#{user.id}")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
