defmodule ExShortener.Schema do
  @moduledoc """
  Commonly used imports and alias for all schemas
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @primary_key {:id, Ecto.UUID, autogenerate: true}

      @typedoc "Schema type"
      @type t :: %__MODULE__{}
    end
  end
end
