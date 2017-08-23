defmodule Trello do

  @default_user_id Trello.ConfigManager.user_id()
  @default_board_id Trello.ConfigManager.board_id()

  def get_boards(user_id \\ @default_user_id, fetch_method \\ &Trello.BoardsInfo.get_boards/1, formatter \\ &Trello.TableFormatter.print_table_for_columns/2) do
    fetch_method.(user_id)
    |> format([:last_activity, :members, :name], formatter)
  end

  def get_cards(board_id \\ @default_board_id, fetch_method \\ &Trello.CardsDetails.get_cards/1, formatter \\ &Trello.TableFormatter.print_table_for_columns/2) do
    fetch_method.(board_id)
    |> format([:last_activity, :name, :members], formatter)
  end

  defp format(list, headers, formatter) when is_list(list) do
    formatter.(list, headers)
  end

  defp format(value, _, _), do: value

end
