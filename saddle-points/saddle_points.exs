defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    rows_in_string = String.split(str, "\n") |> Enum.map(&String.split/1)
    Enum.map(rows_in_string, fn(numbers_in_string) ->
      Enum.map(numbers_in_string, fn(number_in_string) ->
        {number, _} = Integer.parse(number_in_string)
        number
      end)      
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    list_of_rows = rows(str)
    Enum.reduce([head|tail], [], fn(element, aggregator) ->
      
    end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do

  end
end
