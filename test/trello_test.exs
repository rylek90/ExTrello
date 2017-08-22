defmodule TrelloTest do
  use ExUnit.Case
  doctest Trello

  test "greets the world" do
    assert Trello.hello() == :world
  end
end
