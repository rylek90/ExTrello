defmodule Trello.BoardDetails do
# card_name|members|date_of_last_activity
# boards/tBmYPSYe?

  @resource_path "boards/"
  @resource_params %{"fields": "lists,dateLastActivity"}

  def get_board(board_id, fetch_method \\ &Trello.Fetcher.fetch/2) do
    resource_path = "#{@resource_path}#{board_id}"

    fetch_method.(resource_path, @resource_params)
    |> handle_response
  end

  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, reason}), do: "Could not fetch boards info #{reason}"

end
