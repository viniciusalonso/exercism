defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number
    |> Integer.digits()
    |> Enum.map(fn digit ->
      digit ** length(Integer.digits(number))
    end)
    |> Enum.sum()
    |> Kernel.==(number)
  end
end
