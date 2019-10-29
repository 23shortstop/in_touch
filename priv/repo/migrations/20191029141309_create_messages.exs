defmodule InTouch.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
  	create table(:messages) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :chat_id, references(:chats, on_delete: :nothing)

      timestamps()
    end
  end
end
