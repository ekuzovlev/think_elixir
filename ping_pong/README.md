# PingPong

EchoServer с супервизором.

```
$ iex -S mix

PingPong.System.start_link()
> {:ok, #PID<0.152.0>}

PingPong.Server.call(:ping)
> {:pong, :nonode@nohost}

```
