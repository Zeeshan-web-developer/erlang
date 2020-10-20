% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 16:43:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-25 16:55:05
-module(foldl).
-import(lists,[foldl/3]). 
-export([start/1]).


start(List)->

Pred = fun(X, Sum) ->
io:format("~w ",[X]),    
 X + Sum end,

foldl(Pred,0,List).