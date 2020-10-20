% @Author: Zeeshan  Ahmad
% @Date:   2020-09-21 18:16:04
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-21 18:22:28
-module(palindrome).
-export([reverse/2,check_palindrome/1]).


reverse(Num,Rev) when Num == 0->Rev;

reverse(Num,Rev) when Num > 0->
    R=Num rem 10,
    Rev2=Rev*10+R,
    reverse(Num div 10,Rev2).



check_palindrome(Num)->
    Num2=Num,
    Return_val=reverse(Num,0),
    if 
    Return_val == Num2 -> 
        "cool ! Palindrome Number";    
    true -> "oops ! Not a palindrone" 
end.




