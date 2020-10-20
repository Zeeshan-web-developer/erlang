-module(switch2).
-export([fall_velocity/2]).
fall_velocity(P, D) when D >= 0 ->
case P of
x -> {ok,math:sqrt(2 * 9.8 * D)};
y -> {ok,math:sqrt(2 * 1.6 * D)};
z -> {ok,math:sqrt(2 * 3.71 * D)};
Otherwise-> io:format("no match:~p~n",[Otherwise]),
            {error, "coordinate is not x y or z"}
end.