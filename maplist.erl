-module(maplist).
-export([one/0,two/0,add/2]).
one() -> 1.
two() -> 2.
add(X,Y) -> X() + Y().
    