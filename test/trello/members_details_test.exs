defmodule TrelloMembersDetailsTests do
  use ExUnit.Case
  import Trello.MembersDetails

  test "should get name from cache" do
    assert get_names(["1", "2", "3"], nil, nil, fn _ -> "full_name" end)
      == ["full_name", "full_name", "full_name"]
  end

  test "should save fetched names to cache" do

    get_names(
      ["1", "2", "3"],
      fn _, _ -> {:ok, %{"fullName" => "full_name"}} end)

    assert Trello.NamesCache.get_value("1") == "full_name"
    assert Trello.NamesCache.get_value("2") == "full_name"
    assert Trello.NamesCache.get_value("3") == "full_name"
  end

  test "should not save error responses to cache" do
    get_names(["1", "2", "3"], fn _, _ -> {:error, nil} end)

    refute Trello.NamesCache.has_key?("1")
  end

  test "should filter nil responses" do
    full_names = get_names(
      ["1", "2", "3"],
      fn _, _ -> {:ok, %{"fullName" => nil}} end,
      &Trello.NamesCache.save_value/1,
      fn _ -> nil end)

    assert full_names == []
  end

end
