defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    a_count = Enum.count(a)
    b_count = Enum.count(b)

    cond do
      a === b -> :equal
      a == [] -> :sublist
      b == [] -> :superlist
      a_count < b_count && sublist?(a, b) -> :sublist
      a_count > b_count && sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(a, b) do
    a_count = Enum.count(a)
    b_count = Enum.count(b)

    cond do
      b_count < a_count -> false
      Enum.drop(b, a_count - b_count) === a -> true
      true ->
        [b_head|b_tail] = b
        sublist?(a, b_tail)
    end
  end

end
