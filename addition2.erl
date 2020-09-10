%PASSING PARAMETERS DURING compile
-module(addition2). 
-export([sum/2,start/0]). 

sum(X,Y) -> 
   Result = X + Y,
   io:fwrite("~w~n",[Result]).
  
 start()->
       sum(21,43).
   
