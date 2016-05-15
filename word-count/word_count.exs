defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words = split_words(sentence)

    Enum.reduce words, %{}, fn(element, aggregator) ->
      word_count_map = Map.put(aggregator, element, (aggregator[element] || 0) + 1)
      Map.merge(aggregator, word_count_map)
    end
  end

  defp split_words(string) do
    words = remove_special_characters(string)
      |> String.downcase
      |> String.split
      |> remove_empty_string
  end

  defp remove_special_characters(string), do: Regex.replace(~r/[&|\!|@\:|\^|\$|%|,|_]/, string, " ")
  defp remove_empty_string(words), do: Enum.filter(words, fn(word) -> word != "" end)
end
