-module(listevenodd).
-export([listevenodd/1]).



listevenodd([])->
    empty;
listevenodd(list)->
    listevenodd(list,[]).

listevenodd([First|Numbers],Even_No) ->
   case First rem 2  of 
        0 ->
           listevenodd(Numbers,[First | Even_No]);
      _ ->
           listevenodd(Numbers,Even_No) 
     end;

    listevenodd([],Even_No)->
        Even_No.
%-------------------------------------------------------------------
