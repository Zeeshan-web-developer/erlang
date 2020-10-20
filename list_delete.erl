% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 12:40:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 12:42:32
-module(list_delete).
-import(lists,[delete/2]). 
-export([start/2]). 

start(Element,List) -> 
Result=delete(Element,List),
io:fwrite("~w~n",[Result]).