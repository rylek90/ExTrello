defmodule TrelloConfigManagerTest do
  use ExUnit.Case

  defp fake_do_get(key), do: Atom.to_string(key)

  test "should get api_key properly" do
    assert Trello.ConfigManager.api_key(&fake_do_get/1) === "api_key"
  end

  test "should get user_key properly" do
    assert Trello.ConfigManager.user_key(&fake_do_get/1) === "user_key"
  end

  test "should get user_id properly" do
    assert Trello.ConfigManager.user_id(&fake_do_get/1) === "user_id"
  end

  test "should get base_url properly" do
    assert Trello.ConfigManager.base_url(&fake_do_get/1) === "base_url"
  end

end
