% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 10:20:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 11:27:58
-module(list_all).
-import(lists,[all/2]). 
-export([start/0]). 

start() -> 
Pred = fun(E) ->E rem 5 =:= 0 end,
     
Lst1 = [5,10,20,25],  
Status = all(Pred, Lst1), 
io:fwrite("~w~n",[Status]).