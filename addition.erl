%PASSING PARAMETERS DURING RUNTIME
-module(addition). 
-export([sum/2]). 

sum(X,Y) -> 
   Result = X + Y,
   io:fwrite("~f~n",[Result]).
   
