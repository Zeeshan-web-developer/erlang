-module(fib).
-export([fib/1]).

fib(0)->0;

fib(Limit)->
    fib(Limit,1,0,1).

    fib(Limit,I,A,B) when I < Limit ->
        io:fwrite("~p ",[B]),

    fib(Limit,I+1,B,A+B).
