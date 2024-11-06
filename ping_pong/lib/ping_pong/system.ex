defmodule PingPong.System do
  def start_link do
    Supervisor.start_link(
      [
        PingPong.Server
      ],
      strategy: :one_for_one
    )
  end
end
