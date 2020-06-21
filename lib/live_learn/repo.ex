defmodule LiveLearn.Repo do
  use Ecto.Repo,
    otp_app: :live_learn,
    adapter: Ecto.Adapters.Postgres
end
