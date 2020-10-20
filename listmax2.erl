% @Author: Zeeshan  Ahmad
% @Date:   2020-09-18 17:18:04
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-18 18:06:01
%% Find the maximum of a list.
-module(listmax2).
-export([max/1]).

max([]) -> %if we pass empty list
 empty;

max([H|T]) ->  %ISt call
 max2(T, H).



max2([H|T], Max) when H > Max -> 
max2(T, H);

max2([H|T], Max) when H =< Max -> 
max2(T, Max).