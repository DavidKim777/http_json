-module(http_json_handler).

-export([init/2]).

init(Req0, State) ->
  io:format("~n req0: ~p~n", [Req0]),
  {ok, Body, _} = cowboy_req:read_body(Req0),
  Headers = #{<<"content-type">> => <<"application/json">>},
  Map = http_json_protocol:decode(Body),
  io:format("~n Map: ~p~n", [Map]),
  Json = http_json_protocol:encode(Map),
  Req = cowboy_req:reply(200, Headers, Json, Req0),
  {ok, Req, State}.