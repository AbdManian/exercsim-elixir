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
    GenServer.call(machine, {:serve_next_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset)
  end

  # Server callbacks

  @impl GenServer
  def init(init_args) do
    case TakeANumberDeluxe.State.new(
           init_args[:min_number],
           init_args[:max_number],
           Keyword.get(init_args, :auto_shutdown_timeout, :infinity)
         ) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, reson} -> {:stop, reson}
    end
  end

  @impl GenServer
  def handle_call(:report, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:insert_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_val, new_state} ->
        {:reply, {:ok, new_val}, new_state, state.auto_shutdown_timeout}

      {:error, reson} ->
        {:reply, {:error, reson}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, new_val, new_state} ->
        {:reply, {:ok, new_val}, new_state, state.auto_shutdown_timeout}

      {:error, reson} ->
        {:reply, {:error, reson}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, state) do
    {:ok, new_state} =
      TakeANumberDeluxe.State.new(
        state.min_number,
        state.max_number,
        state.auto_shutdown_timeout
      )

    {:noreply, new_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
