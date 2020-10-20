%%%-------------------------------------------------------------------
%% @doc projectManagement public API
%% @end
%%%-------------------------------------------------------------------

-module(projectManagement_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    projectManagement_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
