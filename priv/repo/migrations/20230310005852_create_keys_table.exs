defmodule ExShortener.Repo.Migrations.CreateKeysTable do
  use Ecto.Migration

  def change do
    create table("keys", primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:value, :string)
      add(:expires_at, :naive_datetime)
      add(:used, :boolean)
      add(:url, :string)

      timestamps()
    end

    :keys
    |> unique_index([:value])
    |> create_if_not_exists()
  end
end
