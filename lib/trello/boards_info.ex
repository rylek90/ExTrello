defmodule Trello.BoardsInfo do
  @user_id Trello.ConfigManager.user_id()
  @resource_path "members/#{@user_id}/boards"
  @resource_params %{"fields": "dateLastActivity,id,name"}

  import Trello.Fetcher

  def get_boards(fetch_method \\ &fetch/2), do:
    fetch_method.(@resource_path, @resource_params)
    |> handle_response

  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: "Could not fetch boards info #{reason}"
end
