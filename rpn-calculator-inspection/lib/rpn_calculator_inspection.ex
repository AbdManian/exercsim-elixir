defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn -> calculator.(input) end)
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
    flag_state = Process.flag(:trap_exit, true)

    result =
      Enum.map(inputs, &start_reliability_check(calculator, &1))
      |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, flag_state)

    result
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> calculator.(input) end) end)
    |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
