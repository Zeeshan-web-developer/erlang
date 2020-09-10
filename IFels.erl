-module(IFels). 
-export([hello_world/1]). 

hello_world(A) ->  
   
   if 
      A rem 2 ==0-> 
         io:fwrite("A is even\n"); 
      true -> 
         io:fwrite("A IS odd\n") 
   end.