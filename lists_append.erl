% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 11:58:23
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 12:06:33
-module(lists_append).
-export([start/3]).
-import(lists,[append/2]). 

start(L1,L2,L3)->

Final=append(L1,L2),
Final2=append(Final,L3),
io:fwrite("~p",[Final2]).
