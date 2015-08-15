defmodule Tane.StoreServer do
  use GenServer

  def start_link do
    initial = %{}
    options = [name: __MODULE__]

    GenServer.start_link(__MODULE__, initial, options)
  end

  def store(name, model) do
    GenServer.cast(__MODULE__, {:store, name, model})
  end

  def registered(name) do
    GenServer.call(__MODULE__, {:registered, name})
  end

  def handle_call({:registered, name}, _from, state) do
    {:reply, Dict.get(state, name), state}
  end

  def handle_cast({:store, name, model}, state) do
    new_state = Dict.put(state, name, model)
    {:noreply, new_state}
  end
end
