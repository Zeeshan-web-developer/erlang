% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 12:57:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 13:05:47
-module(drop_while).
-import(lists,[dropwhile/2]). 
-export([start/0]). 

start() -> 
Pred = fun(E) ->E rem 5 == 0 end,
     
Lst1 = [20,10,65,78,20,44],  
Status = dropwhile(Pred, Lst1), 
io:fwrite("~w~n",[Status]).