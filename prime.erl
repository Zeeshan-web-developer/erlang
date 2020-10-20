-module(factorial). 
-export([fact/1]). 


fact(N) when N == 0 -> 1;   %%when value ==0 return 1
fact(N) when N > 0 -> N*fact(N-1). %%otherwise use recursive approach