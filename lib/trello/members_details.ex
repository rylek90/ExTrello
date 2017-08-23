defmodule Trello.MembersDetails do
  @resource_params %{"fields": "fullName"}
  @resource_path "members/"

  def get_names(members_ids, fetch_method \\ &Trello.Fetcher.fetch/2, save_to_cache \\ &Trello.NamesCache.save_value/1, get_from_cache \\ &Trello.NamesCache.get_value/1) do
    Enum.map(members_ids, fn member_id -> get_name(member_id, fetch_method, save_to_cache, get_from_cache) end)
    |> Enum.filter(fn name -> name != nil end)
  end

  defp get_name(member_id, fetch_method, save_to_cache, get_from_cache) do
    get_from_cache.(member_id)
    |> handle_name(member_id, fetch_method, save_to_cache)
  end

  defp handle_name(nil, member_id, fetch_method, save_to_cache) do
    full_name = "#{@resource_path}#{member_id}"
    |> fetch_method.(@resource_params)
    |> handle_response

    save_if_available({member_id, full_name}, save_to_cache)
    full_name
  end

  defp save_if_available({_, nil}, _), do: :ok
  defp save_if_available({member_id, full_name}, save_to_cache), do:
    save_to_cache.({member_id, full_name})

  defp handle_name(full_name, _, _, _), do: full_name

  defp handle_response({:ok, response}), do: response["fullName"]
  defp handle_response({:error, _}), do: nil
end
