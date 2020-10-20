% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 17:02:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 17:03:11
-module(foldr).
-import(lists,[foldr/3]). 
-export([start/1]).


start(List)->

Pred = fun(X, Sum) ->
io:format("~w ",[X]),    
 X + Sum end,

foldr(Pred,0,List).