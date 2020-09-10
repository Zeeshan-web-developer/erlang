-module (adu).
-export([addu/2]).

addu(X, Y) ->
    Result =X+Y,
    io:format("THE SUM OF ~p  AND ~p IS ~p ~n", [X, Y,Result]).