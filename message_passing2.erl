% @Author: Zeeshan  Ahmad
% @Date:   2020-09-18 11:01:02
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-24 16:28:07


-module(message_passing2).
-export([go/0, loop/0]).

go() ->
         Pid = spawn(message_passing2, loop, []),
         Pid ! {self(), hello},
 receive
        {Pid, Msg} ->
        io:format("~w~n",[Msg])
 end,
    Pid ! stop.


loop() ->
        receive
{From, Msg} ->
             From ! {self(), Msg},
 loop();
 stop ->
        true
 end.