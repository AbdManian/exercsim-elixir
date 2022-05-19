# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn ->
      %{
        last_plot_id: 0,
        plot_list: []
      }
    end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plot_list: plot_list} -> plot_list end)
  end

  defp get_last_plot_id(pid) do
    Agent.get(pid, fn x -> x.last_plot_id end)
  end

  def register(pid, register_to) do
    plot_id = get_last_plot_id(pid) + 1

    new_plot = %Plot{plot_id: plot_id, registered_to: register_to}

    Agent.update(pid, fn x ->
      %{
        last_plot_id: plot_id,
        plot_list: x.plot_list ++ [new_plot]
      }
    end)

    new_plot
  end

  defp drop_plot_id(plot_id_list, rmove_id),
    do: Enum.filter(plot_id_list, fn x -> x.plot_id != rmove_id end)

  defp find_by_plot_id(plot_id_list, target_id),
    do: Enum.find(plot_id_list, {:not_found, "plot is unregistered"}, &(&1.plot_id == target_id))

  def release(pid, plot_id) do
    Agent.update(pid, fn x -> %{x | plot_list: drop_plot_id(x.plot_list, plot_id)} end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plot_list: plot_list} -> find_by_plot_id(plot_list, plot_id) end)
  end
end
