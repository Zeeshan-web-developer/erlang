-module(prog1).
-export([admit/5,run/0,circle/1,rectangle/2,square/1]).
-define(Pi, 3.14).


admit(Person,R,L,B,S) ->
    case Person of
       
     case1->
           circle(R);
       
     case2->
        rectangle(L,B);
    
   case3->
    square(S);

     _ ->
            
        "Wrong_Choice"
    end.


run() ->
admit(case1,2,4,3,4).


%Calculate Area of circle
circle(R)->
     Area=?Pi*R,
    io:fwrite("AREA=~p\n",[Area]).

%Calculate Area of rectangle
rectangle(L,B)->
    Area=L*B,
    io:fwrite("AREA=~p\n",[Area]).

%Calculate Area of Square
square(S)->
    Area=S*S,
    io:fwrite("AREA=~p\n",[Area]).
