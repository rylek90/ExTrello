defmodule TrelloTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "should handle boards properly" do
    result = Trello.get_boards(
      "user_id",
      fn _ -> [] end,
      fn _, _ -> "Hello, I'm table" end)

    assert result == "Hello, I'm table"
  end

  test "should handle cards properly" do
    result = Trello.get_cards(
      "board_id",
      fn _ -> [] end,
      fn _, _ -> "Hello, I'm table" end)

    assert result == "Hello, I'm table"
  end

  test "should handle error for boards properly" do
    result = Trello.get_boards(
      "user_id",
      fn _ -> "Serious error!" end,
      fn _, _ -> "Hello, I'm table" end)

    assert result == "Serious error!"
  end

  test "should handle error for cards properly" do
    result = Trello.get_cards(
      "board_id",
      fn _ -> "Serious error!" end,
      fn _, _ -> "Hello, I'm table" end)

    assert result == "Serious error!"
  end
end
