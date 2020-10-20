% @Author: Zeeshan  Ahmad
% @Date:   2020-09-18  2:19:54
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-18 18:20:41

-module(natural).
-export([loop/1]).



loop(Num) when Num == 0->0;

loop(Num)when Num >0 ->
loop(1,Num).

loop(Start,End) when Start >= End ->End;

loop(Start,End)when  Start < End->
io:format("~p",[Start]),
loop(Start+1,End).

