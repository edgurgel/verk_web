[![Build Status](https://travis-ci.org/edgurgel/verk_web.svg?branch=master)](https://travis-ci.org/edgurgel/verk_web)
[![Hex pm](http://img.shields.io/hexpm/v/verk_web.svg?style=flat)](https://hex.pm/packages/verk_web)
[![Coverage Status](https://coveralls.io/repos/edgurgel/verk_web/badge.svg?branch=master&service=github)](https://coveralls.io/github/edgurgel/verk_web?branch=master)

# VerkWeb

Web interface for [Verk](https://github.com/edgurgel/verk)

![Dashboard](http://i.imgur.com/LsDKIVT.png)

## Installation

First, add Verk Web to your `mix.exs` dependencies:

```elixir
def deps do
  [{:verk_web, "~> 1.6"},
   {:verk,     "~> 1.0"}]
end
```

and run

```
$ mix deps.get
```


## If you'd like to mount VerkWeb on another Endpoint:

```elixir
defmodule MyApp.Endpoint do
  use VerkWeb.Mount, path: "/verk"
  ...
end
```

You also have to mount the same path in router.

```elixir
defmodule MyApp.Router do
  use VerkWeb.MountRoute, path: "/verk"
  ...
end
```

Then configure the VerkWeb endpoint to know about the new top level path.

```elixir
# in config.exs

config :verk_web, VerkWeb.Endpoint,
  url: [path: "/verk"]
```

That should be it! :)

## If you'd like to run VerkWeb as stand-alone Endpoint on a different port than the main application:

```elixir
# in config.exs:
config :verk_web, VerkWeb.Endpoint,
  http: [port: 4000],
  server: true, #-> this is to tell VerkWeb to start a standalone application!
  pubsub: [name: VerkWeb.PubSub, adapter: Phoenix.PubSub.PG2] # The pubsub adapter to use (default)
```
Now VerkWeb would run on port 4000,

## Allowing WebSocket connections

VerkWeb's default host configuration is `localhost`. While this works in development, in order to allow WebSocket connections (which are required for the auto-updating overview graph) you need to update the host used in [`Phoenix.Endpoint.url`](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html) to the host from which you are attempting to connect from. If this is not set correctly you can expect the following error message in your browser console logs:

```
WebSocket connection to 'ws://<YOUR_HOST>/socket/websocket?vsn=1.0.0' failed: Error during WebSocket handshake: Unexpected response code: 403
```

To resolve this update your configuration to the actual host for the environment by adding the following configuration:

```elixir
# in config.exs:
config :verk_web, VerkWeb.Endpoint,
  url: [host: "<YOUR_HOST>"]
```

## What it looks like

![Queues](http://i.imgur.com/emoJ3ix.png)
![Retries](http://i.imgur.com/lAALwx4.png)

## Adding authentication

Add to your config:

```elixir
# in config.exs:
config :verk_web, :authorization,
  username: "admin",
  password: "simple_password",
  realm: "Admin Area"
```

or (using environment variables)

```elixir
config :verk_web, :authorization,
  username: {:system, "BASIC_AUTH_USERNAME"},
  password: {:system, "BASIC_AUTH_PASSWORD"},
  realm:    {:system, "BASIC_AUTH_REALM"}
```

## Development

To start Verk Web app:

  1. Install dependencies with `mix deps.get`
  1. Install front-end dependencies `npm install && bower install`
  1. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

