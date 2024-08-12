defmodule Frequency do
  require IEx

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(texts, &count_frequencies/1, max_concurrent: workers)
    |> Stream.map(fn {:ok, a} -> a end)
    |> Enum.reduce(%{}, &merge_maps/2)
  end

  defp count_frequencies(text) do
    text
    |> String.downcase()
    |> String.trim()
    |> String.replace(~r/[^\p{L}]/u, "")
    |> String.graphemes()
    |> Enum.frequencies
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, val1, val2 -> val1 + val2 end)
  end
end
