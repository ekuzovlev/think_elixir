defmodule DualCurrencyPortfolio.MixProject do
  use Mix.Project

  def project do
    [
      app: :dual_currency_portfolio,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
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
      {:httpoison, "~> 2.0"},
      {:poison, "~> 6.0"}
    ]
  end

  defp escript do
    [main_module: DualCurrencyPortfolio]
  end
end
