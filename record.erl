% @Author: Zeeshan  Ahmad
% @Date:   2020-10-12 11:55:30
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-12 12:19:53

-module(record).
-export([start/0]). 
-record(student,{rollno,name,address}).
start()->
Z=#student{name="zeeshan"},
io:format("~p ",[Z#student.name]).
