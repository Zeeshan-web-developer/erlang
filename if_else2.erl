-module(if_else2).
-export([compare/2,run/0]).

compare(A,B)->
   
Result=if
        A > B -> gREATER
        
   
    end,
    io:fwrite("~p IS ~p than ~p\n",[A,Result,B]).

run()->
compare(12,4).


