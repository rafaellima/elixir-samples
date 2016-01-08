defmodule Parallel do
   @moduledoc """
   Processes a collection in parallel
   """
  def pmap(collection, fun) do
    collection
    |> Enum.map(&spawn_process(&1, self, fun))
    |> Enum.map(&await/1)
  end

  defp spawn_process(item, parent, fun) do
    spawn_link fn ->
      send parent, {self, fun.(item)}
    end
  end

  defp await(pid) do
    receive do
      # This pattern match on the pid is necessary to ensure that results are
      # returned in the same order as they were given in the original
      # collection.
      {^pid, result} -> result
    end
  end
end
