defmodule Trello do

  @user_id Trello.ConfigManager.user_id()
  @board_id Trello.ConfigManager.board_id()

  def get_boards(user_id \\ @user_id) do
    Trello.BoardsInfo.get_boards(user_id)
    |> Trello.TableFormatter.print_table_for_columns([:last_activity, :members, :name])
  end

  def get_cards(board_id \\ @board_id) do
    Trello.CardsDetails.get_cards(board_id)
    |> Trello.TableFormatter.print_table_for_columns([:last_activity, :name, :members])
  end

end
