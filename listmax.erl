%% Find the maximum of a list.


max([H|T]) ->  %ISt call
 max2(T, H).

max2([], Max) -> %if we pass empty list
 Max;

max2([H|T], Max) when H > Max -> 
max2(T, H);

max2([_|T], Max) -> 
max2(T, Max).