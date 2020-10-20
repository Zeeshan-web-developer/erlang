% @Author: Zeeshan  Ahmad
% @Date:   2020-09-21 12:00:12
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-21 16:52:49
-module(arm2).
-export([checkdigit/1,armstrong/1]).


checkdigit(Num) when Num ==0-> 1;
checkdigit(Num) when Num >0->
    checkdigit(Num,0).

checkdigit(Num,Digit1) when Num==0->Digit1;
checkdigit(Num,Digit1) when Num > 0->
    checkdigit(Num div 10,Digit1+1).





armstrong(Num)->
    Num2=Num,
    Don=checkdigit(Num),
    armstrong(Num,0,Don,Num2).

    armstrong(Num,Sum,Don,Num2) when Num ==0->
        if 
             Num2==Sum-> 
               io:fwrite("Armstrong\n"); 
            true -> 
               io:fwrite("Number is not armstrong \n") 
         end;
      

armstrong(Num,Sum,Don,Num2) when Num >0->
    R=Num rem 10,
 Sum2=math:pow(R,Don),
 Sum3=Sum2+Sum,
 armstrong(Num div 10,Sum3,Don,Num2).
 

  
      


   





