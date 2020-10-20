% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 17:02:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 17:40:12
-module(list_reverse).
-import(lists,[reverse/2]). 
-export([start/2]).

start(List1,List2)->
Result=reverse(List1,List2),
io:fwrite("~p ",[Result]).