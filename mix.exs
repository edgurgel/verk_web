defmodule VerkWeb.Mixfile do
  use Mix.Project

  @description """
    A Verk dashboard
  """

  def project do
    [app: :verk_web,
     version: "0.9.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: Coverex.Task, coveralls: true],
     name: "Verk Web",
     description: @description,
     package: package,
     deps: deps]
  end

  def application do
    [mod: {VerkWeb, []},
     env: [{VerkWeb.Endpoint, [http: [port: 4000], cache_static_manifest: "priv/static/manifest.json", server: true]}],
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext, :verk]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:phoenix, "~> 1.1.1"},
     {:phoenix_html, "~> 2.3"},
     {:gettext, "~> 0.9"},
     {:verk, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:earmark, "~> 0.1.17", only: :dev},
     {:ex_doc, "~> 0.8.0", only: :dev},
     {:coverex, "~> 1.4.7", only: :test},
     {:meck, "~> 0.8", only: :test}]
  end

  defp package do
    [maintainers: ["Eduardo Gurgel Pinho", "Alisson Sales"],
     licenses: ["MIT"],
     links: %{"Github" => "https://github.com/edgurgel/verk_web"},
     files: ["lib", "web", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"]]
  end
end
