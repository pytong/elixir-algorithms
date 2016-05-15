defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance('', ''), do: 0
  def hamming_distance(strand, strand), do: 0
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do: nil
  def hamming_distance(strand1, strand2), do: calculate(strand1, strand2)

  defp calculate(strand1_nucleotides, strand1_nucleotides, aggregator \\ 0)
  defp calculate([], [], aggregator), do: aggregator
  defp calculate([item|tail1], [item|tail2], aggregator), do: calculate(tail1, tail2, aggregator)
  defp calculate([_|tail1], [_|tail2], aggregator), do: calculate(tail1, tail2, aggregator + 1)
end
