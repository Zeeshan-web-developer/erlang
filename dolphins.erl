% @Author: Zeeshan  Ahmad
% @Date:   2020-09-14 12:33:01
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-14 15:43:34

-module(dolphins).
-export([dolphin3/0]).
dolphin3() ->
 receive
 {From, do_a_flip} ->
 From ! "How about no?",
 dolphin3();

 {From, fish} ->
 From ! "So long and thanks for all the fish!";
 _ ->
 io:format("Heh, we're smarter than you humans.~n"),
 dolphin3()
 end.