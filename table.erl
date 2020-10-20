-module(table).
-export([number/1]).

number(Num) when Num  == 0 ->0;

number(Num) when Num >0 ->
   number(Num,1).

number(Num,I) when I=<10 ->
io:fwrite("~p*~p\n",[Num,I]),
number(Num,I+1).