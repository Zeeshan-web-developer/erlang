%%%-------------------------------------------------------------------
%% @doc calculate top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(calculate_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init(_Args) ->
  SupFlags = #{strategy => one_for_one, intensity => 7, period => 1 },
  %if error occurs in any module only that module shutsdown and starts again

  ChildSpecs = [
    #{id    => calculate,
      start   => {calculate, start_link, []},
      restart => permanent,
      type    => worker,
      modules => [calculate]}
  ],
  {ok, {SupFlags,ChildSpecs}}.