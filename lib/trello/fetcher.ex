defmodule Trello.Fetcher do
  def fetch(url, get_method \\ &HTTPoison.get/1) do
    get_method.(url)
    |> handle_response
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}), do:
    {:ok, Poison.Parser.parse!(body)}

  defp handle_response({_, %{status_code: status, body: body}}), do:
    {:error, Poison.Parser.parse!(body)}

end
