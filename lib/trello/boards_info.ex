defmodule Trello.BoardsInfo do

  defstruct last_activity: nil, id: "", name: ""
  @user_id Trello.ConfigManager.user_id()
  @resource_path "members/#{@user_id}/boards"
  @resource_params %{"fields": "dateLastActivity,id,name"}

  import Trello.Fetcher

  def get_boards(fetch_method \\ &fetch/2), do:
    fetch_method.(@resource_path, @resource_params)
    |> handle_response
    |> map

  defp map(response) when is_list(response), do:
    Enum.map(response, &parse_to_model/1)

  defp map(error_reason), do: error_reason

  defp parse_to_model(details) do
    %Trello.BoardsInfo{
      last_activity: details["dateLastActivity"],
      id: details["id"],
      name: details["name"]
    }
  end

  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: "Could not fetch boards info #{reason}"
end
