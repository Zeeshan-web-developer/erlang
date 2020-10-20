-module(process).
-export([start/0,msg/2]).
msg(0,_Msg)->
    done;
msg(N,Msg)->
    io:format("~p\n",[Msg]),
    msg(N-1,Msg).

start()->
spawn(process,msg,[5,"hello"]),
spawn(process,msg,[5,"how are your"]).