% @Author: Zeeshan  Ahmad
% @Date:   2020-09-14 12:49:45
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-15 12:43:33

-module(dolphinss).
-export([dolphin2/0]).

dolphin2() ->
 receive
 {From, do_a_flip} ->
 From ! "How about no?",
 dolphin2();

 {From, fish} ->
 From ! "So long and thanks for all the fish!";
 _ ->
 io:format("Heh, we're smarter than you humans.~n")
 end.
