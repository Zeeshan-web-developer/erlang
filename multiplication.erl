%PASSING PARAMETERS DURING RUNTIME
-module(multiplication). 
-export([mul/2]). 

mul(X,Y) -> 
   Result = X * Y,
   io:fwrite("~w~n",[Result]).
   
