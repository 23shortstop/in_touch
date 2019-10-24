defmodule InTouch.Messaging.Participant do
  use Ecto.Schema
  import Ecto.Changeset


  schema "participants" do
    field :active_at, :naive_datetime
    field :deleted_at, :naive_datetime

    belongs_to :user, InTouch.Identification.User
    belongs_to :chat, InTouch.Messaging.Chat

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:active_at, :deleted_at, :user_id])
  end
end
