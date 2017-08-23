defmodule Trello.CardsDetails do

  defstruct last_activity: nil, id: "", name: "", members: []
  @resource_params %{"fields": "name,idMembers,dateLastActivity"}

  def get_cards(board_id, fetch_method \\ &Trello.Fetcher.fetch/2, names_fetch \\ &Trello.MembersDetails.get_names/1) do
    format_path(board_id)
    |> fetch_method.(@resource_params)
    |> handle_response
    |> map(names_fetch)
  end

  defp map(response, names_fetch) when is_list(response), do:
    Enum.map(response, &(parse_to_model(&1, names_fetch)))
    |> Enum.sort(fn prev, next -> prev.last_activity > next.last_activity end)

  defp map(error_reason, _), do: error_reason

  defp parse_to_model(details, names_fetch) do
    names = names_fetch.(details["idMembers"])
            |> Enum.join(", ")
             
    %Trello.CardsDetails{
      last_activity: details["dateLastActivity"],
      name: details["name"],
      id: details["id"],
      members: names
    }
  end

  defp format_path(board_id), do: "boards/#{board_id}/cards"
  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: reason

end
