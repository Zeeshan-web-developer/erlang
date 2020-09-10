-module (if_else).
-export([compare/2]).

compare(X, Y) ->
    Result = if
        X > Y -> greater;
        X == Y -> equal;
        X < Y -> less
    end,
    io:format("~p is ~p than ~p ~n", [X, Result, Y]).
