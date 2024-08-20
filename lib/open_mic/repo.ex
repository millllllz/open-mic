defmodule OpenMic.Repo do
  use Ecto.Repo,
    otp_app: :open_mic,
    adapter: Ecto.Adapters.Postgres
end
