-module(forloop). 
-export([loop/1,start/0]). 


loop(10)->
    ok;

loop(Count) ->
    io:fwrite("~p ",[Count]),
    loop(Count+1).


start() ->
    loop(1).


