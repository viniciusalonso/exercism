defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")

  def divide([_n]), do: raise(StackUnderflowError, "when dividing")

  def divide([0, _n]), do: raise(DivisionByZeroError)

  def divide([n, e]), do: div(e, n)
end
