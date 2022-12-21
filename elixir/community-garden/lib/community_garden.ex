# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  def start(opts \\ []) do
    Agent.start(fn -> {1, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, list} -> list end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {count, list} ->
      new_id = count + 1
      plot = %Plot{plot_id: count, registered_to: register_to}
      {plot, {new_id, [plot | list]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {count, list} ->
      new_state = Enum.filter(list, fn plot -> plot.plot_id != plot_id end)
      {count, new_state}
    end)
  end

  def get_registration(pid, plot_id) do
    filtered =
      list_registrations(pid)
      |> Enum.filter(fn plot -> plot.plot_id == plot_id end)
      |> List.first()

    case filtered do
      nil -> {:not_found, "plot is unregistered"}
      %Plot{} -> filtered
    end
  end
end
