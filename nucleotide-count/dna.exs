defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    nucleotides = to_nucleotides(strand)

    unless validate_nucleotides(nucleotides) && validate_nucleotides([<<nucleotide>>]) do
      raise ArgumentError
    end

    case nucleotides do
      [] -> 0
      _ -> count_nucleotides(nucleotides, nucleotide)
    end
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    nucleotides = to_nucleotides(strand)

    unless validate_nucleotides(nucleotides) do
      raise ArgumentError
    end

    Enum.reduce @nucleotides, %{}, fn(item, aggregator) ->
      Map.put(aggregator, item, count_nucleotides(nucleotides, item))
    end
  end

  defp validate_nucleotides(nucleotides) do
    uniq_nucleotides = Enum.uniq(nucleotides)
    Enum.all?(uniq_nucleotides, fn(nucleotide) ->
      <<eacute::utf8>> = nucleotide
      Enum.member?(@nucleotides, eacute)
    end)
  end

  defp to_nucleotides(strand), do: String.codepoints(to_string(strand))
  defp count_nucleotides(nucleotides, nucleotide), do: Enum.filter(nucleotides, fn(x) -> x == <<nucleotide>> end) |> Enum.count
end
