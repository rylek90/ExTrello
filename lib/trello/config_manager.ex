defmodule Trello.ConfigManager do

  def api_key(get_strategy \\ &do_get/1), do: get_strategy.(:api_key)
  def user_key(get_strategy \\ &do_get/1), do: get_strategy.(:user_key)
  def user_id(get_strategy \\ &do_get/1), do: get_strategy.(:user_id)
  def base_url(get_strategy \\ &do_get/1), do: get_strategy.(:base_url)

  defp do_get(key) do
    Application.get_env(:trello, key)
  end
end
