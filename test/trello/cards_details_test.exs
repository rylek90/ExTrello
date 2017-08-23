defmodule TrelloCardsDetailsTest do
  use ExUnit.Case

  import Trello.CardsDetails

  defp success(_, _), do: {:ok, [%{
      "dateLastActivity" => "dateLastActivity",
      "name" => "name",
      "id" => "id",
      "idMembers" => ["1", "2"]
    }]}

  defp error(_, _), do: {:error, "some_error"}

  @tag :ignore
  test "should handle bad response" do
    assert get_cards("some_id", &error/2, nil) == "some_error"
  end

  test "should get details properly" do
    [card] = get_cards("some_id", &success/2, fn _ -> ["SomeName"] end)

    assert card.id == "id"
    assert card.last_activity == "dateLastActivity"
    assert card.members == ["SomeName"]
    assert card.name == "name"
  end

end
