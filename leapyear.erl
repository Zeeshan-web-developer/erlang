% @Author: Zeeshan  Ahmad
% @Date:   2020-10-08 00:34:41
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-08 00:46:03
-module(leapyear).
-export([start/1]).

start(N) ->
    if 
      N rem 2==0 ->
         if 
              N rem  400 -> 
               io:fwrite("Leap"); 
            true -> 
               io:fwrite("Leap")
         end;
         
      true -> 
         io:fwrite("Not a leap") 
   end.

