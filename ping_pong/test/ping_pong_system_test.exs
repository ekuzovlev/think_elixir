defmodule PingPongSystemTest do
  use ExUnit.Case

  test "server process is running under supervisor" do
    {:ok, _pid} = PingPong.System.start_link()

    assert Process.whereis(PingPong.Server) != nil
  end
end
