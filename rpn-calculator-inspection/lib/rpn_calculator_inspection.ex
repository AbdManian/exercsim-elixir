defmodule RPNCalculatorInspection do

  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn ->calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    reply =
      receive do
        {:EXIT, ^pid, :normal} -> :ok
        {:EXIT, ^pid, _} -> :error
      after
        100 -> :timeout
      end

    Map.put(results, input, reply)
  end

  def reliability_check(calculator, inputs) do
    # Please implement the reliability_check/2 function
  end

  def correctness_check(calculator, inputs) do
    # Please implement the correctness_check/2 function
  end
end
