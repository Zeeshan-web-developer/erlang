% @Author: Zeeshan  Ahmad
% @Date:   2020-09-22 15:15:06
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-22 20:25:01
-module(string1).
-import(string,[to_lower/1,str/1,to_upper/1,sub_string/3,len/1,is_empty/1]). 
-export([start/2]).

%start()->
    
        %Str1 = "WELCOME TO GOFIBER", 
        %Str2 = to_lower(Str1), 
        %io:fwrite("~p~n",[Str2]).

        %start()->
    
         %   Str1 = "welcome to gofiber", 
          %  Str2 = to_upper(Str1), 
           % io:fwrite("~p~n",[Str2]).

           %start(Str1) -> 
           
            %Str2 = sub_string(Str1,4,13), 
            %io:fwrite("~p~n",[Str2]).

            %start(Str1) -> 
           
             %   Str2 = len(Str1), 
              %  io:fwrite("~p~n",[Str2]).

%calculate total no. of words in a string
  %start(Str2)->
   %W=string:words(Str2),
   %io:format("~p=",[W]).


% start(Str2)->
 %  W=string:is_empty(Str2),
  % io:format("~p=",[W]).

start(StringList,Operattor)->
    Z=string:join(StringList,Operattor),
    io:format("~p",[Z]).