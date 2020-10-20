% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 14:23:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 14:52:44
-module(list_duplicate).
-import(lists,[duplicate/2]). 
-export([start/2]). 

start(Times,Element) -> 
Status = duplicate(Times,Element), 
io:fwrite("~w~n",[Status]).