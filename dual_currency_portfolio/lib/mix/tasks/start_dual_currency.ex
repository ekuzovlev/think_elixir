defmodule Mix.Tasks.StartDualCurrency do
  use Mix.Task

  @shortdoc "Запускает программу"
  def run(_) do
    DualCurrencyPortfolio.main()
  end
end
