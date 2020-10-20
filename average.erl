% @Author: Zeeshan  Ahmad
% @Date:   2020-09-17 21:37:55
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-17 23:15:24

-module(average).
-export([sum/1,calc/1]).

sum(0)->0;

sum(Num)->
    Num+sum(Num-1).


calc(Limit)->
              Avg = sum(Limit),
              Avg2=Avg div Limit,
              io:fwrite("Total Average is=~p",[Avg2]).

