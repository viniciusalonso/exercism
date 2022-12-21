defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    ~r/(.)\1*/
    |> Regex.scan(string)
    |> Enum.map(fn [count, char] ->
      case String.length(count) do
        length when length > 1 -> to_string(String.length(count)) <> char
        _ -> char
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    numbers_as_string = Enum.to_list(1..9) |> Enum.map(&to_string/1)

    if String.contains?(string, numbers_as_string) do
      ~r/\d+\s+|\d+\w{1}|\s{1}|\w{1}/
      |> Regex.scan(string)
      |> List.flatten()
      |> Enum.map(&format_decode_output/1)
      |> Enum.join()
    else
      string
    end
  end

  defp format_decode_output(content) do
    result = String.split(content, ~r/\d+/, include_captures: true, trim: true)

    case length(result) do
      a when a > 1 -> String.duplicate(List.last(result), String.to_integer(List.first(result)))
      1 -> result
    end
  end
end
