-module(guardscase).
-export([admit/1,run/0]).

admit(Person) ->
    case Person of
        {N} when N == 10 ->
            equal_TO_ten;
       
     {N} when N > 10 ->
        greater_than_Ten;
       
     {N} when N< 10 ->
        less_than_Ten;
            _ ->
            no_match_found
    end.

run() ->
  
Value = {5},
io:format(admit(Value)),
io:nl().
