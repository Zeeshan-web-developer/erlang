-module(ps).
-export([is_armstrong_number/1]).

digits(0, Acc) -> Acc;
digits(Num, Acc) ->
        digits( Num div 10, [Num rem 10 | Acc]).

is_armstrong_number(N) ->
        Digits = digits(N, []),
        Length = length(Digits),
        N == lists:foldl(fun(X, Sum) -> Sum + math:pow(X, Length) end, 0,Digits).
