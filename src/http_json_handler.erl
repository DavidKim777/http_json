-module(http_json_handler).

-export([init/2]).

init(Req0, State) ->
  Path =  cowboy_req:path(Req0),
  {ok, Body, _} = cowboy_req:read_body(Req0),
  Map = http_json_protocol:decode1(Body),
  case http_json_validate:validate(Path, Map) of
    {ok, Json} ->
      Headers = #{<<"content-type">> => <<"application/json">>},
      dispatch(Headers, Json, Req0, State);
    {error, Reason} ->
      Headers = #{<<"content-type">> => <<"application/json">>},
      ErrorJson = http_json_protocol:encode(#{error => Reason}),
      {ok, cowboy_req:reply(400, Headers, ErrorJson, Req0), State}
  end.

dispatch(Headers, Json, Req0, State) ->
    try
        Json01 = maps:get(date, Json),
        Map1 = http_json_protocol:decode(Json01),
        Response = #{data => Map1},
        Json1 = http_json_protocol:encode(Response),
        Req = cowboy_req:reply(200, Headers, Json1, Req0),
        {ok, Req, State}
    catch
         _:_ ->
            ErrorJson = http_json_protocol:encode(#{error => <<"no corect JSON">>}),
            {ok, cowboy_req:reply(400, Headers, ErrorJson, Req0), State}
    end.