defmodule TrelloUrlFetcherTest do
  use ExUnit.Case
  @some_url "some_url"

  defp success_response(_), do:
    {:ok, %{status_code: 200, body: Poison.encode!(%{"key" => "value"})}}

  defp bad_response(_), do:
    {:error, %{status_code: 500, body: "reason"}}

  test "should handle success response properly" do
    {:ok, body} = Trello.Fetcher.fetch(@some_url, %{}, &success_response/1)
    assert body["key"] == "value"
  end

  test "should handle other response properly" do
    {:error, body } = Trello.Fetcher.fetch(@some_url, %{}, &bad_response/1)
    assert body == "reason"
  end
end
