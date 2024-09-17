defmodule DualCurrencyPortfolio do
  @moduledoc """
  Обрабатывает пользовательский ввод (курс доллара в рублях, количество
  накоплений в рублях и долларах) и выводит в консоль рекомендацию по обмену.
  """

  @doc """
  Эта функция вызывается для запуска программы.
  """
  def main do
    get_io_data()
    |> calculate()
    |> print_data()
  end

  defp get_io_data do
    {rate, _} = sanitize_data("Какой сейчас курс доллара?")
    {rubles, _} = sanitize_data("Сколько у вас рублей?")
    {dollars, _} = sanitize_data("Сколько у вас долларов?")

    {rate, rubles, dollars}
  end

  defp sanitize_data(question) do
    IO.gets("#{question}\n") |> String.trim() |> Float.parse()
  end

  defp calculate({rate, rubles, dollars}) do
    rubles_to_dollars = rubles / rate
    all_dollars = rubles_to_dollars + dollars
    target_balance = all_dollars / 2
    usd = Float.round(abs(dollars - target_balance), 2)

    {usd, rubles_to_dollars, target_balance}
  end

  defp print_formatted(value) do
    :erlang.float_to_binary(value, decimals: 2)
  end

  defp print_data({usd, rubles_to_dollars, target_balance}) when rubles_to_dollars < target_balance do
    IO.puts("Вам нужно продать USD #{print_formatted(usd)}")
  end

  defp print_data({usd, rubles_to_dollars, target_balance}) when rubles_to_dollars > target_balance do
    IO.puts("Вам нужно купить USD #{print_formatted(usd)}")
  end

  defp print_data({_, _, _}) do
    IO.puts("Ваш портфель сбалансирован")
  end
end
