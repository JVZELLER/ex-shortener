defmodule ExShortener.Repo.Migrations.CreateCounterSequence do
  use Ecto.Migration

  def up do
    execute("CREATE SEQUENCE IF NOT EXISTS counter AS bigint")
  end

  def down do
    execute("DROP SEQUENCE IF EXISTS counter")
  end
end
