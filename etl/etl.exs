defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    old_keys = Map.keys(input)
    Enum.reduce old_keys, %{}, fn(element, aggregator) ->
      Map.merge(aggregator, add_to_map(input[element], element))
    end
  end

  defp add_to_map(keys, value) do
    Enum.reduce keys, %{}, fn(element, aggregator) ->
      Map.put(aggregator, String.downcase(element), value)
    end
  end
end
