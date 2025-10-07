-module(http_json).

-export([start/0]).

start() ->
  io:format("~n res: ~p~n", [ok]),
  application:ensure_all_started(?MODULE).
