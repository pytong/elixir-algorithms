defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @daynum_map %{ 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday, 7 => :sunday }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    days_of_the_month = 
      case schedule do
        :first -> Enum.to_list(1..7)
        :second -> Enum.to_list(8..14)
        :third -> Enum.to_list(15..21)
        :fourth -> Enum.to_list(22..28)
        :teenth -> Enum.to_list(13..19)
        :last ->
          last_day_of_the_month = :calendar.last_day_of_the_month(year, month) - 6
          Enum.to_list(last_day_of_the_month..last_day_of_the_month + 7)
      end
    
    find_day_of_week(days_of_the_month, year, month, weekday)
  end

  defp find_day_of_week([head|tail], year, month, weekday) when tail == [], do: {year, month, head}
  defp find_day_of_week([head|tail], year, month, weekday) do
    cond do
      get_day_of_week_string(year, month, head) == weekday -> {year, month, head}
      true -> find_day_of_week(tail, year, month, weekday)
    end
  end

  defp get_day_of_week_string(year, month, day), do: @daynum_map[:calendar.day_of_the_week(year, month, day)]
end
