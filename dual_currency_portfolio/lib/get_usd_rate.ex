defmodule GetUsdRate do
  @url "https://www.cbr-xml-daily.ru/daily_json.js"

  @moduledoc """
  Получает курсы валют с сайта
  """

  @doc """
  Эта функция вызывается делает запрос на получение курса валют и возвращает
  курс доллара в рублях.
  """
  def get_rate do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"Valute" => %{"USD" => %{"Value" => value}}}} = Poison.decode(body)
        {:ok, value}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
        {:error, reason: "Not found :("}
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        {:error, reason: reason}
    end
  end
end
