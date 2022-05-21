defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(term) do
      case term do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> term}
      end
    end
  end

  def divide(stack) when length(stack) < 2, do: raise(StackUnderflowError, "when dividing")

  def divide([0, _]), do: raise(DivisionByZeroError)

  def divide([a, b]), do: div(b, a)
end
