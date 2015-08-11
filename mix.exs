defmodule Tane.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tane,
      version: "0.2.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description,
      package: package,
      docs: docs,
      deps: deps
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    Library for Seeding Databases
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      contributors: ["Joe Honzawa"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/Joe-noh/tane"
      },
      build_tools: ["mix"]
    ]
  end

  defp docs do
    [readme: "README.md", main: "README"]
  end

  defp deps do
    [
      {:meck, "~> 0.8", only: :test},

      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc,  "~> 0.7", only: :dev}
    ]
  end
end
