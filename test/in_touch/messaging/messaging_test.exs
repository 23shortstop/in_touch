defmodule InTouch.MessagingTest do
  use InTouch.DataCase

  alias InTouch.Messaging

  describe "messanges" do
    alias InTouch.Messaging.Message

    test "create_message/1 with valid data creates a message" do
      user = insert(:user)
      chat = insert(:chat)

      valid_attrs = %{body: "some text", user_id: user.id, chat_id: chat.id}

      assert {:ok, %Message{} = message} = Messaging.create_message(valid_attrs)
      assert message.body == "some text"
      assert message.user_id == user.id
      assert message.chat_id == chat.id
    end

    test "create_message/1 with invalid data returns error changeset" do
      invalid_attrs = %{body: "some text", user_id: 0, chat_id: 0}

      assert {:error, %Ecto.Changeset{}} = Messaging.create_message(invalid_attrs)
    end
  end
end
