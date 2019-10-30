defmodule InTouch.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    belongs_to :user, InTouch.Identification.User
    belongs_to :chat, InTouch.Messaging.Chat

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :user_id, :chat_id])
    |> validate_required([:body, :user_id, :chat_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:chat_id)
  end
end
