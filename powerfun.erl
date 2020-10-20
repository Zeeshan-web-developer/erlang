% @Author: Zeeshan  Ahmad
% @Date:   2020-09-21 15:43:10
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-21 16:08:52
-module(powerfun).
-export([start/1]).


start(Num)->
    math:pow(Num,5).