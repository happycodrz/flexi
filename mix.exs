defmodule Flexi.MixProject do
  use Mix.Project
  @version "0.2.0"

  def project do
    [
      app: :flexi,
      version: @version,
      elixir: "~> 1.7-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A flexible Elixir ExUnit test runner, perfect in combination with Cortex",
      source_url: "https://github.com/happycodrz/flexi",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cortex, "~> 0.5", only: [:dev, :test]},
      {:mockery, "~> 2.2", only: [:dev, :test]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp package do
    %{
      maintainers: ["Roman Heinrich"],
      licenses: ["MIT License"],
      links: %{"Github" => "https://github.com/happycodrz/flexi"}
    }
  end
end
