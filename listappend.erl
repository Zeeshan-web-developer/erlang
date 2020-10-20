% @Author: Zeeshan  Ahmad
% @Date:   2020-09-25 10:20:09
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-09 12:52:46
-module(listappend).
-export([start/0]). 

start() -> 
L2=[12],
K=lists:last(L2), 
io:format("~w ",[K]).