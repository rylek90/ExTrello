defmodule Trello.BoardDetails do

  defstruct last_activity: nil, id: "", name: "", members: []
  @resource_params %{"fields": "name,idMembers,dateLastActivity"}

  def get_board(board_id, fetch_method \\ &Trello.Fetcher.fetch/2, names_fetch \\ &Trello.MembersDetails.get_names/1) do
    format_path(board_id)
    |> fetch_method.(@resource_params)
    |> handle_response
    |> Enum.filter(fn details -> details != nil end)
    |> Enum.map(&(parse_to_model(&1, names_fetch)))
  end

  defp parse_to_model(details, names_fetch) do
    %Trello.BoardDetails{
      last_activity: details["dateLastActivity"],
      name: details["name"],
      id: details["id"],
      members: names_fetch.(details["idMembers"])
    }
  end

  defp format_path(board_id), do: "boards/#{board_id}/cards"
  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: nil

end
