defmodule LearnLoop.Repo do
  use Ecto.Repo,
    otp_app: :learn_loop,
    adapter: Ecto.Adapters.SQLite3
end
