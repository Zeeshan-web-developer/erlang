% @Author: Zeeshan  Ahmad
% @Date:   2020-09-21 11:04:54
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-21 11:34:06
-module(printtable).
-export([print_table/1]).

print_table(Num) when Num ==0->"Zero_table";

print_table(Num)when Num >0 ->
print_table(Num,1).

print_table(Num,I) when I < 10->
      M=Num*I,
    io:format("~p*~p=~p~n",[Num,I,M]),  
    print_table(Num,I+1);

    print_table(Num,I) when I == 10->
        M=Num*I,
       io:format("~p*~p=~p~n",[Num,I,M]).
      