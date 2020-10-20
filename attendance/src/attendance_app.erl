%%%-------------------------------------------------------------------
%% @doc attendance public API
%% @end
%%%-------------------------------------------------------------------

-module(attendance_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    attendance_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
