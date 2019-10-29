use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :in_touch, InTouchWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :in_touch, InTouch.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "in_touch_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
