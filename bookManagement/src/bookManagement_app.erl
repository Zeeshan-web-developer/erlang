%%%-------------------------------------------------------------------
%% @doc bookManagement public API
%% @end
%%%-------------------------------------------------------------------

-module(bookManagement_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    bookManagement_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
