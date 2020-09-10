% Find the area for circle, Rectangle, Square (using case)?
-module(functions1).
-export([admit/1]).

admit(Person) ->
 
    case Person of
        {circle}  ->
            io:fwrite("hello");
       
     {rectangle} ->
        io:fwrite("hello")

        _ ->
            unknown
    end.



