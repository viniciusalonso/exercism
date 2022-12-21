defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    for {_quantity, values} <- input,
        value <- values do
      {String.downcase(value), find_value_point(value)}
    end
    |> format_response
  end

  defp format_response(list, format \\ %{})
  defp format_response([], format), do: format

  defp format_response(list, format) do
    [head | tail] = list
    {key, value} = head

    format_response(tail, Map.put(format, key, value))
  end

  defp find_value_point(value) do
    values = %{
      1 => ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
      2 => ["D", "G"],
      3 => ["B", "C", "M", "P"],
      4 => ["F", "H", "V", "W", "Y"],
      5 => ["K"],
      8 => ["J", "X"],
      10 => ["Q", "Z"]
    }

    [point] = for {point, values} <- values, Enum.member?(values, value), do: point
    point
  end
end
