defmodule InTouch.Messaging.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :title, :string
    field :type, :string
    field :direct_fingerprint, {:array, :integer}

    has_many :participants, InTouch.Messaging.Participant
    many_to_many :users, InTouch.Identification.User,
                 join_through: InTouch.Messaging.Participant

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:type, :title, :direct_fingerprint])
    |> validate_required([:type])
    |> unique_constraint(:participants, name: :direct_fingerprint_index)
  end
end
