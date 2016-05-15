defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates), do: Enum.filter(candidates, fn(candidate) -> anagram?(base, candidate) end)

  defp anagram?(base, candidate) do
    base_downcase = String.downcase(base)
    candidate_downcase = String.downcase(candidate)

    cond do
      base_downcase == candidate_downcase -> false
      true -> to_sorted_chars(base_downcase) == to_sorted_chars(candidate_downcase)
    end
  end

  defp to_sorted_chars(string), do: string |> String.split("") |> Enum.sort
end
