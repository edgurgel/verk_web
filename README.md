[![Build Status](https://travis-ci.org/edgurgel/verk_web.svg?branch=master)](https://travis-ci.org/edgurgel/verk_web)
[![Hex pm](http://img.shields.io/hexpm/v/verk_web.svg?style=flat)](https://hex.pm/packages/verk_web)
[![Coverage Status](https://coveralls.io/repos/edgurgel/verk_web/badge.svg?branch=master&service=github)](https://coveralls.io/github/edgurgel/verk_web?branch=master)
# VerkWeb

## Development

To start Verk Web app:

  1. Install dependencies with `mix deps.get`
  1. Install front-end dependencies `npm install && bower install`
  1. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Using 

First, add Verk Web to your `mix.exs` dependencies:

```elixir
def deps do
  [{:verk_web, "~> 0.9"},
   {:verk,     "~> 0.9"}]
end
```

and run 

```
$ mix deps.get
```

Now, list `:verk_web` and `:verk` applications as your application dependencies. They must run together on the same node.

```elixir
def application do
  [applications: [:verk_web, :verk]]
end
```
