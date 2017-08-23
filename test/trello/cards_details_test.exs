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

  test "should be sorted by descending by date" do
    cards = get_cards("some_id", fn _, _ -> {:ok, [%{
        "dateLastActivity" => "aaaa",
        "name" => "name",
        "id" => "id",
        "idMembers" => ["1", "2"]
      },
      %{
          "dateLastActivity" => "zzzz",
          "name" => "name",
          "id" => "id",
          "idMembers" => ["1", "2"]
        }
      ]}
    end,
    fn _ -> ["SomeName"] end)

    dates = Enum.map(cards, fn card_info -> card_info.last_activity end)

    assert dates == ["zzzz", "aaaa"]
  end
end
