defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    chars = String.codepoints(str)

    bracket_stack = Enum.reduce chars, [], fn(item, aggregator) ->
      cond do
        opening_bracket?(item) -> push(item, aggregator)
        closing_bracket?(item) -> process_bracket(item, aggregator)
        true -> aggregator
      end
    end

    empty?(bracket_stack)
  end

  defp process_bracket(bracket, aggregator) do
    last_bracket_on_stack = peek(aggregator)

    case bracket do
      "}" ->
        case last_bracket_on_stack do
          "{" -> pop(aggregator)
          _ -> push(bracket, aggregator)
        end
      "]" -> 
        case last_bracket_on_stack do
          "[" -> pop(aggregator)
          _ -> push(bracket, aggregator)
        end
      ")" ->
        case last_bracket_on_stack do
          "(" -> pop(aggregator)
          _ -> push(bracket, aggregator)
        end
      true -> push(bracket, aggregator)
    end
  end

  defp empty?([]), do: true
  defp empty?(_), do: false
  defp push(item, list), do: [item|list]
  defp pop([head|tail]), do: tail
  defp peek([]), do: nil
  defp peek([item|_]), do: item

  defp opening_bracket?(bracket), do: Enum.any?(["{", "[", "("], fn(x) -> x == bracket end)
  defp closing_bracket?(bracket), do: Enum.any?(["}", "]", ")"], fn(x) -> x == bracket end)
end
