% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 10:20:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 12:27:05
-module(lists_concat).
-import(lists,[concat/1]). 
-export([start/1]). 

start(List) -> 
Result=concat(List),
io:fwrite("~p~n",[Result]).