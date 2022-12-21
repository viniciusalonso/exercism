defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}

  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}

  def convert(digits, input_base, output_base) do
    if not Enum.all?(digits, &(&1 >= 0 and &1 < input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      digits
      |> Enum.with_index()
      |> Enum.map(fn {x, i} -> x * input_base ** (length(digits) - 1 - i) end)
      |> Enum.sum()
      |> Integer.digits()
      |> convert_output_base(output_base)
    end
  end

  defp convert_output_base([0], _), do: {:ok, [0]}

  defp convert_output_base(digits, output_base) do
    number =
      digits
      |> Enum.join()
      |> String.to_integer()

    convert_output(number, output_base)
  end

  defp convert_output(number, output_base, acc \\ [])
  defp convert_output(0, _, acc), do: {:ok, acc}

  defp convert_output(number, output_base, acc),
    do: convert_output(div(number, output_base), output_base, [rem(number, output_base) | acc])
end
