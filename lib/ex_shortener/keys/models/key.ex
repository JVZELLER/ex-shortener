defmodule ExShortener.Keys.Models.Key do
  @moduledoc """
  Represents the seven character keys we generate to replace long URLs
  """

  use ExShortener.Schema

  alias ExShortener.AvailableKeys.Models.AvailableKey

  schema "keys" do
    field(:value, :string)
    field(:expires_at, :naive_datetime)
    field(:used, :boolean)

    has_one(:available_key, AvailableKey)

    timestamps()
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(schema \\ %__MODULE__{}, params) do
    fields = __schema__(:fields)

    schema
    |> cast(params, fields)
    |> validate_required(fields)
  end
end
