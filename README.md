# VerkWeb

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  1. Install brunch dependencies with `npm install`
  1. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

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

Now, list `:verk_web` and `:verk` applications as your application dependency. They must run together on the same node.

```elixir
def application do
  [applications: [:verk_web, :verk]]
end
```
