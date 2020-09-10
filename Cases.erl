-module(cases). 
-export([start/1]). 

start(A) -> 
  case A rem 2  of 
      0 -> 
         io:fwrite("~p is an even number\n",[A]); 
   
    _ ->
         io:fwrite("~p is an odd number\n",[A])        
   end.