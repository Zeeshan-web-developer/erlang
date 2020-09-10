-module(armstrong).
-export([start/1]).

start(Num) when Num =<0->0;

   start(Num) when Num > 0->
      ((Num rem 10)*(Num rem 10)*(Num rem 10))+start(floor(Num/10)).
 


