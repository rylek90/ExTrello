defmodule Trello.UrlFormatter do
  @base_url Trello.ConfigManager.base_url()
  @api_key Trello.ConfigManager.api_key()
  @user_key Trello.ConfigManager.user_key()

  def format_for(route, params \\ %{}) do
    query_string = get_query_string(params)
    uri = URI.merge(@base_url, route) |> URI.to_string
    URI.parse("#{uri}?#{query_string}")
  end

  defp get_query_string(params) do
    append_auth(params)
    |> URI.encode_query
  end

  defp append_auth(params) do
    params
    |> Map.put(:key, @api_key)
    |> Map.put(:token, @user_key)
  end
end
