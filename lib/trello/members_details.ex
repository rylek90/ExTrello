defmodule Trello.MembersDetails do
  @resource_params %{"fields": "fullName"}
  @resource_path "members/"

  def get_names(members_ids, fetch_method \\ &Trello.Fetcher.fetch/2) do
    Enum.map(members_ids, fn name -> get_name(name, fetch_method) end)
    |> Enum.filter(fn name -> name != nil end)
  end

  defp get_name(member_id, fetch_method \\ &Trello.Fetcher.fetch/2) do
    "#{@resource_path}#{member_id}"
    |> fetch_method.(@resource_params)
    |> handle_response
  end

  defp handle_response({:ok, response}), do: response["fullName"]
  defp handle_response({:error, _}), do: nil
end
