defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new({white_x, white_y} \\ {0, 3} , {black_x, black_y} \\ {7, 3}) do
    if white_x == black_x && white_y == black_y do
      raise ArgumentError
    end
    %Queens{white: {white_x, white_y}, black: {black_x, black_y}}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    rows = Enum.to_list(0..7)
    Enum.reduce(rows, "", fn(row, aggregator) ->
      aggregator <> draw_row(row, queens) <> "\n"
    end) |> String.strip
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    {white_x, white_y} = queens.white
    {black_x, black_y} = queens.black

    cond do
      white_x == black_x -> true
      white_y == black_y -> true
      diagonal?(queens) -> true
      true -> false
    end
  end

  defp draw_row(row_num, queens) do
    {white_x, white_y} = queens.white
    {black_x, black_y} = queens.black

    case row_num != white_x && row_num != black_x  do
      true -> "_ _ _ _ _ _ _ _"
      _ ->
        columns = Enum.to_list(0..7)
        Enum.reduce(columns, "", fn(column, aggregator) ->
          cond do
            row_num == white_x && column == white_y -> aggregator <> "W "
            row_num == black_x && column == black_y -> aggregator <> "B "
            true -> aggregator <> "_ "
          end
        end) |> String.strip
    end
  end

  defp diagonal?(queens) do
    {white_x, white_y} = queens.white
    {black_x, black_y} = queens.black

    abs(white_x - black_x) == abs(white_y - black_y)
  end
end
