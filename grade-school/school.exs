defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    case db[grade] do
      nil -> Map.put(db, grade, [name])
      list -> Map.put(db, grade, list ++ [name])
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    names = db[grade]
    case names do
      nil -> []
      _ -> names
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    sorted_keys = Map.keys(db) |> Enum.sort

    Enum.reduce sorted_keys, [], fn(element, aggregator) ->
      aggregator ++ [{ element, Enum.sort(db[element]) }]
    end

  end
end
