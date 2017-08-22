defmodule Trello.NamesCache do
  use GenServer
  @name :names_cache

  def save_value({id, full_name}) do
    start_if_dead()
    GenServer.cast(@name, {:save_name, id, full_name})
  end

  def get_value(id) do
    start_if_dead()
    GenServer.call(@name, {:name, id})
  end

  def handle_call({:name, id}, _from, cache) do
    {:reply, Map.get(cache, id), cache}
  end

  def handle_cast({:save_name, id, name}, cache) do
    new_cache = Map.put(cache, id, name)
    {:noreply, new_cache}
  end

  defp start_if_dead() do
    value = case GenServer.whereis(:names_cache) do
      nil -> GenServer.start_link(__MODULE__, %{}, [name: @name])
      _ -> nil
    end
  end

end
