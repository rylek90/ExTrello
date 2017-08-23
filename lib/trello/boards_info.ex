defmodule Trello.BoardsInfo do

  defstruct last_activity: nil, id: "", name: ""
  @resource_params %{"fields": "dateLastActivity,id,name"}

  import Trello.Fetcher

  def get_boards(user_id, fetch_method \\ &fetch/2) do
    resource_path = format_resource_path(user_id)

    fetch_method.(resource_path, @resource_params)
    |> handle_response
    |> map
  end

  defp map(response) when is_list(response), do:
    Enum.map(response, &parse_to_model/1)
    |> Enum.sort(fn prev, next -> prev.last_activity > next.last_activity end)

  defp map(error_reason), do: error_reason

  defp format_resource_path(user_id), do: "members/#{user_id}/boards"

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
