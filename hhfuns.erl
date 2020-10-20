-module(hhfuns).
-export([incr/1,decr/1,cap/2]).

incr(X) -> X + 1.
decr(X) -> X - 1.

cap(_, []) -> [];

cap(F, [H|T]) -> 
[F(H)|cap(F,T)].
