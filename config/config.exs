# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :catch_all,
  ecto_repos: [CatchAll.Repo],
  hashid_salt: "salt",
  smtp_opts: [[port: 2525, sessionoptions: []]]

# Configures the endpoint
config :catch_all, CatchAll.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dC7X6RIxsCmn7VCsVmOlO60HldarPT6h6B/f/onZDEXEF9V7QUwUnZDFf3W0g2As",
  render_errors: [view: CatchAll.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CatchAll.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
