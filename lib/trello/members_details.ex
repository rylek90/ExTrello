defmodule Trello.MembersDetails do
  @resource_params %{"fields": "fullName"}
  @resource_path "members/"

  def get_names(members_ids, fetch_method \\ &Trello.Fetcher.fetch/2) do
    Enum.map(members_ids, fn id -> get_name(id, %{}, fetch_method) end)
    |> Enum.filter(fn name -> name != nil end)
  end

  defp get_name(member_id, cache, fetch_method \\ &Trello.Fetcher.fetch/2) do
    Map.get(cache, member_id, nil)
    |> fetch_value(member_id, cache, fetch_method)
  end

  defp fetch_value(nil, member_id, cache, fetch_method) do
    full_name = "#{@resource_path}#{member_id}"
    |> fetch_method.(@resource_params)
    |> handle_response

    cache_new = Map.put(cache, member_id, full_name)
    IO.inspect cache_new
    full_name
  end

  defp fetch_value(full_name, _, _) do
    IO.puts "Get from cache #{full_name}"
    full_name
  end

  defp handle_response({:ok, response}), do: response["fullName"]
  defp handle_response({:error, _}), do: nil
end
