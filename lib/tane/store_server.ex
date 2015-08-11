defmodule Tane.StoreServer do
  use GenServer

  defstruct models: %{}

  def start_link do
    GenServer.start_link(__MODULE__, %__MODULE__{}, [name: __MODULE__])
  end

  def store(model) do
    GenServer.cast(__MODULE__, {:store, model})
  end

  def get_by(model_module, conditions) do
    GenServer.call(__MODULE__, {:get_by, model_module, conditions})
  end

  def dump do
    GenServer.call(__MODULE__, :dump)
  end

  def handle_call(:dump, _from, state) do
    {:reply, state.models, state}
  end

  def handle_call({:get_by, model_module, conditions}, _from, state) do
    models = state.models
      |> Dict.get(model_module, [])
      |> Enum.filter fn model ->
        Enum.all? conditions, fn {key, val} ->
          Map.get(model, key) == val
        end
      end

    {:reply, List.last(models), state}
  end

  def handle_cast({:store, model}, state) do
    new_state = store_model(model, state)
    {:noreply, new_state}
  end

  defp store_model(model, state) do
    key = model.__struct__
    new_models = Map.update(state.models, key, [model], &[model | &1])

    %__MODULE__{state | models: new_models}
  end
end
