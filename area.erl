-module(area).
-export([area/1]).

area({square, Side}) ->
 Side * Side ;
area({circle, Radius}) ->
 math:pi() * Radius * Radius;
area({rectriangle,L,B}) ->
 L*B;
area(Other) ->
 wrong_choice.
