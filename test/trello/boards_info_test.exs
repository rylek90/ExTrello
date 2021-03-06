defmodule TrelloBoardsInfoTest do
  use ExUnit.Case

  defp success(_, _), do: {:ok, [%{
      "dateLastActivity" => "dateLastActivity",
      "name" => "name",
      "id" => "id",
    }]}
  defp error(_, _), do: {:error, "some_error"}

  test "should handle response properly" do
    [board] = Trello.BoardsInfo.get_boards(nil, &success/2)
    assert board.last_activity == "dateLastActivity"
    assert board.name == "name"
    assert board.id == "id"
  end

  test "should handle error properly" do
    assert Trello.BoardsInfo.get_boards(nil, &error/2) == "Could not fetch boards info some_error"
  end

  test "should be sorted by descending by date" do
    boards = Trello.BoardsInfo.get_boards(nil, fn _, _ -> {:ok, [%{
        "dateLastActivity" => "aaaa",
        "name" => "name",
        "id" => "id",
      },
      %{
          "dateLastActivity" => "zzzz",
          "name" => "name",
          "id" => "id",
        }
      ]}
    end)

    dates = Enum.map(boards, fn board_info -> board_info.last_activity end)

    assert dates == ["zzzz", "aaaa"]
  end

end
