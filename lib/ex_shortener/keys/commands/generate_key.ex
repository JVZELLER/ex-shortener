defmodule ExShortener.Keys.Commands.GenerateKey do
  @moduledoc """
  Generatese sevent character keys used to replace URLs.

  It follows these steps:
    1. Get the next value from a database counter
    2. Apply a B62 hash algorithm to generate the key value
    3. Inserte a new record on both `keys` and `available_keys` tables.
  """
  import Ecto.Query

  alias ExShortener.AvailableKeys.Models.AvailableKey
  alias ExShortener.Counter.Commands.GetCounterNextValue
  alias ExShortener.Keys.Commands.EncodeB62
  alias ExShortener.Keys.Models.Key
  alias ExShortener.Repo

  @spec execute(String.t()) :: {:ok, Key.t()} | {:error, Ecto.Changeset.t()}
  def execute(url) do
    AvailableKey
    |> Repo.one()
    |> case do
      %AvailableKey{} = available ->
        update_key_to_used(available, url)

      nil ->
        generate_key(url)
    end
  end

  defp update_key_to_used(%AvailableKey{key_id: key_id} = available, url) do
    now_plus_thirty_minutes = get_expiration_time(30)

    params = [used: true, url: url, expires_at: now_plus_thirty_minutes]

    fn ->
      {1, [key]} =
        Key
        |> where(id: ^key_id)
        |> update(set: ^params)
        |> select([k], k)
        |> Repo.update_all([])

      {:ok, _} = Repo.delete(available)

      {:ok, key}
    end
    |> Repo.transaction()
    |> handle_transaction_result()
  end

  defp generate_key(url) do
    counter_value = GetCounterNextValue.execute()
    key = EncodeB62.execute(counter_value)
    key_id = Ecto.UUID.generate()

    params = %{
      id: key_id,
      value: key,
      used: true,
      url: url,
      expires_at: get_expiration_time(30)
    }

    fn ->
      params
      |> Key.changeset()
      |> Repo.insert()
      |> case do
        {:ok, result} ->
          result

        error ->
          error
      end
    end
    |> Repo.transaction()
    |> handle_transaction_result()
  end

  defp get_expiration_time(minutes_to_add) do
    NaiveDateTime.add(NaiveDateTime.utc_now(), minutes_to_add, :minute)
  end

  defp handle_transaction_result(result) do
    case result do
      {:error, error} ->
        error

      {:ok, result} ->
        result
    end
  end
end
