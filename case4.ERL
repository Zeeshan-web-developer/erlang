-module(case4).
-export([admit/1,run/0]).

admit(integer) ->
    case integer of
        integer rem 2
        {0}  ->
            "THE NUMBER IS EVEN";
        _ ->
            "THE NUMBER IS EVEN"
    end.

run() ->

io:fwrite(admit( {nofemale})),
io:nl().