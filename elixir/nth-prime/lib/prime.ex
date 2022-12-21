defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    calculate_prime(count)
  end

  defp calculate_prime(count, previous_primes \\ [2])

  defp calculate_prime(count, previous_primes) when length(previous_primes) == count,
    do: List.last(previous_primes)

  defp calculate_prime(count, previous_primes) do
    calculate_prime(count, previous_primes ++ [find_next_prime(previous_primes)])
  end

  defp find_next_prime(previous_primes, count \\ 1)

  defp find_next_prime(previous_primes, count) do
    next_prime = List.last(previous_primes) + count

    not_is_next_prime =
      Enum.map(previous_primes, fn divisor ->
        rem(next_prime, divisor) == 0
      end)
      |> Enum.member?(true)

    if not_is_next_prime, do: find_next_prime(previous_primes, count + 1), else: next_prime
  end
end
