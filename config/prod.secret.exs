use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :catch_all, CatchAll.Endpoint,
  secret_key_base: "fBSCmCdffRD8dZgk+rb/qyruo6sas/U4sSKeTB9lkMbPVkoSNxuVpfc7bO7lhsUs"

# Configure your database
config :catch_all, CatchAll.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "FerJKfNgnbFjmFYGDgg6xLiE",
  database: "catch_all_prod",
  pool_size: 20
