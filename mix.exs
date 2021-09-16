defmodule Squabble.MixProject do
  use Mix.Project

  def project do
    [
      app: :squabble,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      description: description(),
      package: package(),
      homepage_url: "https://github.com/oestrich/squabble",
      source_url: "https://github.com/oestrich/squabble"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [mod: {Squabble.Application, []}, extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  def description() do
    "Simple leader election for your cluster"
  end

  def package() do
    [
      maintainers: ["Eric Oestrich"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/oestrich/squabble"}
    ]
  end
end
