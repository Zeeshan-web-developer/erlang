-module(summ).
-export([add/1]).


add(Limit) when Limit==0->0;

add(Limit) when Limit > 0->

     Limit+add(Limit-1).