-module(lists1).
-export([start/0,listappend/2]).

listappend(List1,List2)->
    lists:append(List1,List2).
    
start()->
    listappend([1,2,3],["A","B","C"]).