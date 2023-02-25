defmodule ExShortener.Repo do
  use Ecto.Repo,
    otp_app: :ex_shortener,
    adapter: Ecto.Adapters.Postgres
end
