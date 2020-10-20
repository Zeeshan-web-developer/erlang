%8) Find the largest and smallest number of a list? (use recursion)?
-module(tut12).
-export([listlen/1]).

listlen([]) -> 0;

listlen([Head|Xs]) ->
      Head+listlen(Xs).  


