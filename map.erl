-module(map).
-export([start/0]).
start() -> 
   P=[1,7,{'sadam','kulsum'},[1,2],{person, 'Joe', 'Armstrong'},{person, 'Robert', 'Virding'}],

   io:fwrite("~w",[length(P)]).
