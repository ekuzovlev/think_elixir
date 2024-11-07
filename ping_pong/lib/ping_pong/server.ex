defmodule PingPong.Server do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def call(request) do
    GenServer.call(__MODULE__, request)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @impl true
  def handle_call(:ping, _, state) do
    {:reply, {:pong, node()}, state}
  end

  def handle_call(_other, _, state) do
    {:reply, {:error, :allow_only_ping}, state}
  end
end
