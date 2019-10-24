defmodule InTouch.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :active_at, :naive_datetime
      add :deleted_at, :naive_datetime
      add :chat_id, references(:chats, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:participants, [:chat_id])
    create index(:participants, [:user_id])
  end
end
