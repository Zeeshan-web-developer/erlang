% @Author: Zeeshan  Ahmad
% @Date:   2020-09-29 16:40:28
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-29 17:40:28

-module(group_chat_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).


%this is just like Admin
start_link() ->
    supervisor:start_link(group_chat_sup, []).

init(_Args) ->
    SupFlags = #{strategy => one_for_one, intensity => 5, period => 5 },
          %if error occurs in any module only that module shutsdown and starts again

     ChildSpecs = [
                    #{id    => standup,
                    start   => {standup, start_link, []},
                    restart => permanent,
                    type    => worker,
                    modules => [standup]}
                 ],
    {ok, {SupFlags,ChildSpecs}}.                