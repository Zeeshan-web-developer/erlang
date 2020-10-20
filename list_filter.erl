% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 03:17:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 16:19:50
-module(list_filter).
-import(lists,[filter/2]). 
-export([start/0]). 

start() -> 
Pred = fun(E) ->E rem 2 == 0 end,
     
Lst1 = [17,10,210,25,78],  
Status = filter(Pred, Lst1), 
io:fwrite("~w~n",[Status]).