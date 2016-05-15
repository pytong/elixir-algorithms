defmodule Bob do
  def hey(input) do
    cond do
      empty?(input) ->
        "Fine. Be that way!"
      question?(input) ->
        "Sure."
      shouting?(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  defp empty?(string), do: String.strip(string) == ""
  defp question?(string), do: String.last(string) == "?"
  defp numbers_only?(string), do: Regex.match?(~r/\d+(, \d+)*$/, string)
  defp shouting?(string), do: !numbers_only?(string) && String.upcase(string) == string
end
