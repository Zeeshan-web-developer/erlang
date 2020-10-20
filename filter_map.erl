% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 16:23:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 16:35:23
-module(list_duplicate).
-import(lists,[filtermap/2]). 
-export([start/2]). 

start(Times,Element) -> 
    
   filtermap(fun(X) -> 
       case X rem 2 of
    
     0 -> {true, X div 2};
     _ -> false end end, [1,2,3,4,5]).