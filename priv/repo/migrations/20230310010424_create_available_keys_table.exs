defmodule ExShortener.Repo.Migrations.CreateAvailableKeysTable do
  use Ecto.Migration

  def change do
    create table("available_keys", primary_key: false) do
      add(:key_id, references("keys", type: :uuid))

      timestamps()
    end
  end
end
