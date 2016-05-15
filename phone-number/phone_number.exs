defmodule Phone do
  @bad_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    formatted_number = String.replace(raw, ~r/[\(|\)|\-|\.|\+|\s]/, "")
    number_length = String.length(formatted_number)

    cond do
      number_length < 10  -> @bad_number
      number_length == 11 ->
        case String.at(formatted_number, 0) do
          "1" -> String.slice(formatted_number, 1, number_length - 1)
          _ -> @bad_number
        end
      number_length > 11 -> @bad_number
      true -> formatted_number
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    formatted_number = number(raw)
    case String.length(formatted_number) do
      10 -> String.slice(formatted_number, 0, 3)
      11 -> String.slice(formatted_number, 1, 3)
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    area_digits = area_code(raw)
    formatted_number = number(raw)
    local_digits_first_chunk = (formatted_number |> String.slice(3, 3))
    local_digits_second_chunk = (formatted_number |> String.slice(6, 4))

    "(#{area_digits}) #{local_digits_first_chunk}-#{local_digits_second_chunk}"
  end
end
