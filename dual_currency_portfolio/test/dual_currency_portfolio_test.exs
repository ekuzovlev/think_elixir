defmodule DualCurrencyPortfolioTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "the portfolio is balanced" do
    input =
      """
      1
      100
      100
      """
    assert capture_io([input: input], fn -> DualCurrencyPortfolio.main() end) ==
      """
      Какой сейчас курс доллара?
      Сколько у вас рублей?
      Сколько у вас долларов?
      Ваш портфель сбалансирован
      """
  end

  test "you need to sell dollars" do
    input =
      """
      92.34
      1
      999
      """
    assert capture_io([input: input], fn -> DualCurrencyPortfolio.main() end) ==
      """
      Какой сейчас курс доллара?
      Сколько у вас рублей?
      Сколько у вас долларов?
      Вам нужно продать USD 499.49
      """
  end

  test "you need to buy dollars" do
    input =
      """
      2
      200
      50
      """
    assert capture_io([input: input], fn -> DualCurrencyPortfolio.main() end) ==
      """
      Какой сейчас курс доллара?
      Сколько у вас рублей?
      Сколько у вас долларов?
      Вам нужно купить USD 25.00
      """
  end
end
