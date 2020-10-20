-module(hello).
-export([hello/0]).
-import(io,[format/1]).

hello()->
    format("HELLO WORLD \n").
