-module(operators).
-export([start/0]). 
    start() -> 
        N = 9, 
        if  N > 10 -> 
              io:fwrite("N is greater than 10"); 
           
        true -> 
              io:fwrite("N is less than 10") 
        end.