% @Author: Zeeshan  Ahmad
% @Date:   2020-09-22 15:35:08
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-22 15:35:41
-module(math1).
-export([even/1, odd/1]).

even(Integer) -> (Integer >= 0) and (Integer rem 2 =:= 0).
odd(Integer) -> (Integer >= 1) and (Integer rem 2 =/= 0).