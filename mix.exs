defmodule Tane.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tane,
      version: "0.2.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      elixirc_paths: elixirc_paths(Mix.env),
      description: description,
      package: package,
      docs: docs,
      deps: deps
    ]
  end

  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test) do
    [:ecto, :sqlite_ecto | applications(:dev)]
  end

  defp applications(_env) do
    [:logger]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env),  do: ["lib"]

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
      {:ecto,        "~> 0.15", only: :test},
      {:sqlite_ecto, "~> 0.5",  only: :test},

      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc,  "~> 0.7", only: :dev}
    ]
  end
end
