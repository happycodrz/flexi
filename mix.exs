defmodule Flexi.MixProject do
  use Mix.Project
  @version "0.4.1"

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
      extra_applications: [:logger],
      mod: {Flexi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:ex_doc, ">= 0.0.0", only: :dev}
      {:ex_doc, github: "elixir-lang/ex_doc", only: :dev}
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
