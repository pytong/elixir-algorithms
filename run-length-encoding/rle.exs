defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    consecutive_characters = find_consecutive_characters(string)
    Enum.reduce consecutive_characters, "", fn(element, aggregator) ->
      encoded_string = (String.length(element) |> Integer.to_string) <> String.first(element)
      aggregator <> encoded_string
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    codes = split_code(string)
    Enum.reduce codes, "", fn(element, aggregator) ->
      numTimes = List.first(element) |> String.to_integer
      char = List.last(element)
      decoded_string = String.duplicate(char, numTimes)
      aggregator <> decoded_string
    end
  end

  defp split_code(string) do
    matching_groups = Regex.scan(~r/(\d+)([A-Z])/, string)
      |> Enum.map(fn(matching_group) -> Enum.drop(matching_group, 1) end)
  end

  defp find_consecutive_characters(string) do
    matching_groups = Regex.scan(~r/([A-Z])\1*/, string)
      |> Enum.map(fn(matching_group) -> List.first(matching_group) end)
  end

end


