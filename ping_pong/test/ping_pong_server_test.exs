defmodule PingPongServerTest do
  use ExUnit.Case

  test "server process is running" do
    {:ok, pid} = PingPong.Server.start_link(nil)

    assert Process.whereis(PingPong.Server) == pid
  end

  test "server reply on :ping" do
    {:ok, _pid} = PingPong.Server.start_link(nil)

    assert {:pong, node()} == PingPong.Server.call(:ping)
  end

  test "server don't reply others" do
    {:ok, _pid} = PingPong.Server.start_link(nil)

    assert {:error, :allow_only_ping} == PingPong.Server.call(:other)
  end
end
