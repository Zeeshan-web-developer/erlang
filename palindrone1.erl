% @Author: Zeeshan  Ahmad
% @Date:   2020-09-17 18:33:30
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-17 18:41:02

-module(palindrone1).
-export([reverseNum/2, checkPlaindrome/1]).

reverseNum(0, Res)->
  Res;

reverseNum(N,Res) ->
                    Rem = N rem 10,
                    Res1 = Res * 10 + Rem,
reverseNum(N div 10, Res1).  

checkPlaindrome(N) ->
  Rev = reverseNum(N,0),

  if
    Rev == N -> plaindrome ;
    true -> not_plaindrome
  end.