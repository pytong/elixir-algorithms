defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    words = Regex.replace(~r/[,|-]/, string, " ")
      |> add_space_to_contiguous_words
      |> String.upcase
      |> String.split
      |> Enum.map(&String.first/1)
      |> Enum.join
  end

  defp add_space_to_contiguous_words(string), do: Regex.replace(~r/[a-z]([A-Z])/, string, " \\1")
end
