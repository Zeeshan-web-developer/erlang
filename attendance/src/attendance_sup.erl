%%%-------------------------------------------------------------------
%% @doc attendance top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(attendance_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
init([]) ->
  SupFlags = #{strategy => one_for_one,
    intensity => 2,
    period => 1},
  ChildSpecs = [#{id => attendancedb,
    start => {attendancedb, start_link, []},
    type => worker
  },
    #{id => attendance,
      start => {attendance, start_link, []},
      type => worker
    }],
  {ok, {SupFlags, ChildSpecs}}.
