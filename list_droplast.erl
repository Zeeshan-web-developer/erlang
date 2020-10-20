% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 12:51:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 12:52:34
-module(list_droplast).
-import(lists,[droplast/1]). 
-export([start/1]). 

start(List) -> 
Result=droplast(List),
io:fwrite("~w~n",[Result]).