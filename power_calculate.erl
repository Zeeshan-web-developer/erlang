% @Author: Zeeshan  Ahmad
% @Date:   2020-09-18 10:04:41
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-18 18:15:01
%PRogram to calculate the power of a number
-module(power_calculate).
-export([power/2]).


power(Base,Exp) when Exp==0 ->1;

power(Base,Exp) when Exp >0 ->
    Base*power(Base,Exp-1).

