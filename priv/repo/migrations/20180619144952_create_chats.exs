defmodule InTouch.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :type, :string
      add :title, :string
      add :direct_fingerprint, {:array, :integer}

      timestamps()
    end

    create unique_index(:chats, [:direct_fingerprint],
                        name: :direct_fingerprint_index,
                        where: "type = 'direct'")
  end
end
