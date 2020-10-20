% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 10:20:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 11:42:47
-module(list_any).
-import(lists,[any/2]). 
-export([start/0]). 

start() -> 
Pred = fun(E) ->E rem 5 =:= 0 end,
     
Lst1 = [7,10,20,25],  
Status = any(Pred, Lst1), 
io:fwrite("~w~n",[Status]).