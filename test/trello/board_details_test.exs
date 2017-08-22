defmodule TrelloBoardDetailsTest do
  use ExUnit.Case

  defp success(_, _), do: {:ok, "some_response"}
  defp error(_, _), do: {:error, "some_error"}

  test "should handle response properly" do
    assert Trello.BoardDetails.get_board("some", &success/2) == "some_response"
  end

  test "should handle error properly" do
    assert Trello.BoardDetails.get_board("some", &error/2) == "Could not fetch boards info some_error"
  end
end
