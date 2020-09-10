-module(saving). 
-export([start/2]). 


start(A,B) -> 

   Result=if 
      A == B -> equal;
      A > B ->  greater
      
   end,
   io:format("~p is ~p than ~p ~n", [A, Result, B]).


