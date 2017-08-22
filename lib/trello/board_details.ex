defmodule Trello.BoardDetails do

  defstruct last_activity: nil, id: "", name: "", members: []
  @resource_params %{"fields": "name,idMembers,dateLastActivity"}

  def get_board(board_id, fetch_method \\ &Trello.Fetcher.fetch/2) do
    format_path(board_id)
    |> fetch_method.(@resource_params)
    |> handle_response
    |> Enum.filter(fn details -> details != nil end)
    |> Enum.map(&parse_to_model/1)
  end

  defp parse_to_model(details) do
    %Trello.BoardDetails{
      last_activity: details["dateLastActivity"],
      name: details["name"],
      id: details["id"],
      members: Trello.MembersDetails.get_names(details["idMembers"])
    }
  end

  defp format_path(board_id), do: "boards/#{board_id}/cards"
  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: nil

end
