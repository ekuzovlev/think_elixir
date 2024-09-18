defmodule DualCurrencyPortfolio do
  import GetUsdRate
  @moduledoc """
  Обрабатывает пользовательский ввод (курс доллара в рублях, количество
  накоплений в рублях и долларах) и выводит в консоль рекомендацию по обмену.
  """

  @doc """
  Эта функция вызывается для запуска программы.
  """
  IO.puts(
    """
    Эта программа расчитывает баланс вашего бивалютного портфеля и дает
    необходимые рекомендации в случае необходимости.

    Вам необходимо ответить на поставленные вопросы. Обратите внимание, что
    допускается ввод только чисел с плавающей точкой.

    Например: 322.00 или 23,01
    """)

  def main(args \\ []) do
    case args do
      [] ->
        get_and_print_rate()
        |> get_io_data()
        |> calculate()
        |> print_data()

      _ when is_list(args) ->
        args
        |> parse_args()
        |> calculate()
        |> print_data()
    end
  end

  defp get_and_print_rate do
    case get_rate() do
      {:ok, rate} -> print_rate({:ok, rate})
      {:error, reason} -> print_rate({:error, reason})
    end
  end

  defp print_rate({:ok, rate}) do
    IO.puts("На сегодня курс доллара #{rate}")
    {:ok, rate}
  end

  defp print_rate({:error, reason}) do
    IO.puts("Ошибка получения курса: #{reason}")
    {:error, reason}
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: [rate: :float, rub: :float, usd: :float]) do
      {[rate: rate, rub: rubles, usd: dollars], _, _} ->
        {rate, rubles, dollars}

      _ ->
        {:error, "Некорректный набор аргументов. Ожидались параметры: --rate, --rub, --usd"}
        IO.puts("Некорректный набор аргументов. Ожидались параметры: --rate, --rub, --usd")
        System.halt(1)
        # ИЛИ обработку этого error лучше вынести в main???
    end
  end

  defp get_io_data({:ok, rate}) do
    rate = rate
    rubles = sanitize_data("Сколько у вас рублей?")
    dollars = sanitize_data("Сколько у вас долларов?")

    {rate, rubles, dollars}
  end

  defp get_io_data({:error, _}) do
    rate = sanitize_data("Какой сейчас курс доллара?")
    rubles = sanitize_data("Сколько у вас рублей?")
    dollars = sanitize_data("Сколько у вас долларов?")

    {rate, rubles, dollars}
  end

  defp sanitize_data(question) do
    IO.gets("#{question}\n")
    |> check_input()
  end

  defp check_input(input) do
    try do
      String.to_float(String.trim(input))
    rescue
      ArgumentError ->
        IO.puts("Ошибка: введено некорректное число")
        check_input(IO.gets("Попробуйте снова:\n"))
    end
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
