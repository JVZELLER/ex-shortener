defmodule ExShortener.AvailableKeys.Models.AvailableKey do
  @moduledoc """
  Represents the already generated and still available seven character keys used to replace URLs.
  """

  use ExShortener.Schema

  alias ExShortener.Keys.Models.Key

  schema "available_keys" do
    belongs_to(:key, Key, type: Ecto.UUID)

    timestamps()
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(schema \\ %__MODULE__{}, params) do
    fields = __schema__(:fields)

    schema
    |> cast(params, fields)
    |> validate_required([:key_id])
  end
end
