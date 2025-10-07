-module(http_json_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	io:format("~n applicatione start: ~p~n", [ok]),
	Dispatch = cowboy_router:compile([
		{'_', [{"/", http_json_handler, []}]}
	]),
	{ok, _} = cowboy:start_clear(http_json_listener,
		[{port, 8080}],
		#{env => #{dispatch => Dispatch}}
	),
	http_json_sup:start_link().

stop(_State) ->
	ok = cowboy:stop_listener(http_json_listener).
