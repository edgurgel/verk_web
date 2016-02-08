use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :verk_web, VerkWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :verk, queues: [{:default, 1}], redis_url: "redis://127.0.0.1:6379/10"
