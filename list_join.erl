% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 17:02:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 17:23:27
-module(list_join).
-import(lists,[join/2]). 
-export([start/2]).

start(Seprator,List)->
Result=join(Seprator,List),
io:fwrite("~w ",[Result]).