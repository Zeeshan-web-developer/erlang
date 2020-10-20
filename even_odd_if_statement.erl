-module(even_odd_if_statement).
-export([even/1]).

even(A)->
    if
        A rem 2==0 ->
            io:fwrite("Number is even\n");
        true->
            io:fwrite("Number is odd\n")
    end.

