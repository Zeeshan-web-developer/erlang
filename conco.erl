% @Author: Zeeshan  Ahmad
% @Date:   2020-09-18 12:22:11
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-18 12:22:12
-module(conco).
-export([main/1,start/0]).

start()->
 spawn(?MODULE,main,[0]).

 main(T)->

 receive
 {Pid,stop}->Pid!stpeed;

 {Pid,N}->
 Next=N+T,
 Pid!Next,
 main(Next)
 end.