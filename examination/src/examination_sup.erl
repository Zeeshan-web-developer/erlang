
-module(examination_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one, intensity => 5, period => 2 },
  %if error occurs in any module only that module shutsdown and starts again

  ChildSpecs = [
    #{id    => examination,
      start   => {examination, start_link, []},
      restart => permanent,
      type    => worker,
      modules => [examination]}
  ],
  {ok, {SupFlags,ChildSpecs}}.
