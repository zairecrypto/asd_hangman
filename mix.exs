defmodule Hangman.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:cowboy, :plug, :dictionary],
      extra_applications: [:logger],
      test_coverage: [tool: Coverex.Task], 
      test_coverage: [tool: Coverex.Task, log: :debug]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:dictionary, github: "rawandrew/dictionary"},
      {:elixir_uuid, "~> 1.2"},
      {:poison, "~> 3.1"},
      {:cowboy, "~> 2.0", override: true},
      {:plug, "~> 1.0"},
      {:mock, "~> 0.3.0", only: :test}, 
      {:coverex, "~> 1.4.10", only: :test}
    ]
  end
end
