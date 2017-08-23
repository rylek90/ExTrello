defmodule TrelloBoardsInfoTest do
  use ExUnit.Case

  defp success(_, _), do: {:ok, [%{
      "dateLastActivity" => "dateLastActivity",
      "name" => "name",
      "id" => "id",
    }]}
  defp error(_, _), do: {:error, "some_error"}

  test "should handle response properly" do
    [board] = Trello.BoardsInfo.get_boards(&success/2)
    assert board.last_activity == "dateLastActivity"
    assert board.name == "name"
    assert board.id == "id"
  end

  test "should handle error properly" do
    assert Trello.BoardsInfo.get_boards(&error/2) == "Could not fetch boards info some_error"
  end

end
