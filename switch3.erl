-module(switch3).
-export([admit/1,run/0]).

admit(Person) ->
    case Person of
        {male}  ->
            yes_with_cover;
       
     {female} ->
            yes_no_cover;
       
     {nomale} ->
            no_boy_admission;
    
    {nofemale} ->
            no_girl_admission;

        _ ->
            unknown
    end.

run() ->

io:fwrite(admit( {nofemale})),
io:nl().