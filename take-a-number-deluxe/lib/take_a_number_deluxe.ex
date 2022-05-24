defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
   GenServer.call(machine, :report)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :insert_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
  end

  # Server callbacks

  @impl GenServer
  def init(init_args) do
    case TakeANumberDeluxe.State.new(init_args[:min_number], init_args[:max_number]) do
      {:ok, state} -> {:ok, state}
      {:error, reson} -> {:stop, reson}
    end
  end

  @impl GenServer
  def handle_call(:report, _from, state) do
    {:reply, state, state}
  end


  @impl GenServer
  def handle_call(:insert_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_val, new_state} -> {:reply, {:ok, new_val}, new_state}
      {:error, reson} -> {:stop, reson, state}
    end

  end
end
