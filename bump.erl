-module(bump).
-export([sum_acc/2]).

sum_acc([],Sum) -> Sum;

sum_acc([Head|Tail], Sum) ->
     sum_acc(Tail, Head+Sum).


   

