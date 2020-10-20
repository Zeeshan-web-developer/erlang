%%%-------------------------------------------------------------------
%% @doc stopwatch public API
%% @end
%%%-------------------------------------------------------------------

-module(stopwatch_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    stopwatch_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
