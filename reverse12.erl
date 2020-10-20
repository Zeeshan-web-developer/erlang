-module(reverse12). 
-export([series2/1,start/0]). 

series2(NUM) when NUM =<0  ->  NUM;



series2(NUM) when NUM > 0 -> 
    R= NUM rem 10,
    
     (R*10)+series2(floor(NUM/10)).

start()->
    series2(923456).


