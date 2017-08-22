defmodule Trello.Fetcher do
  def fetch(url, params \\ %{}, get_method \\ &HTTPoison.get/1, url_format \\ &Trello.UrlFormatter.format_for/2) do
    raw_response = url_format.(url, params)
    |> get_method.()
    |> handle_response
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}), do:
    {:ok, Poison.Parser.parse!(body)}

  defp handle_response({_, %{status_code: status, body: body}}), do:
    {:error, Poison.Parser.parse!(body)}

end
