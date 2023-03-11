defmodule ExShortener.Counter.Commands.GetCounterNextValue do
  @moduledoc """
  Gets the next value of 'counter' sequence in database.
  """
  alias ExShortener.Repo

  @spec execute() :: integer()
  def execute do
    ~s/select nextval('counter')/
    |> Repo.query!()
    |> Map.get(:rows)
    |> List.flatten()
    |> List.first()
  end
end
