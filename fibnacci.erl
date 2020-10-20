-module(fibnacci).
-export([fib/1]).

fib(Limit) when Limit == 0 -> 0;   %%when value ==0 return 1
fib(Limit) when Limit == 1 -> 1;


fib(Limit) when Limit > 1 -> 
fib(Limit-2)+fib(Limit-1).



 


