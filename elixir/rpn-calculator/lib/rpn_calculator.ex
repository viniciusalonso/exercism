defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    case calculate_verbose(stack, operation) do
      result = {:ok, _} -> result
      {:error, _} -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      e -> {:error, Exception.message(e)}
    end
  end
end
