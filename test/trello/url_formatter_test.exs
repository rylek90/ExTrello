defmodule TrelloUrlFormatterTest do
  use ExUnit.Case
  @path "some/path"

  test "should contain correct path" do
    url = Trello.UrlFormatter.format_for(@path)
    assert url.path == "/1/some/path"
  end

  test "should contain correct base url" do
    url = Trello.UrlFormatter.format_for(@path)
    assert url.host == "api.trello.com"
  end

  test "should contain auth data" do
    url = Trello.UrlFormatter.format_for(@path)
    parsed_query = URI.decode_query(url.query)
    assert Map.has_key?(parsed_query, "token")
    assert Map.has_key?(parsed_query, "key")
  end
end
