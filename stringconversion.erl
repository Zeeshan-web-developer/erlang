-module(stringconversion).
-export([start/0]).
-import(string,[to_upper/1]).
 
start() ->
S1 = "string conversion to uppercase",
S2 = to_upper(S1),
io:fwrite("~p~n",[S2]).