% @Author: Zeeshan  Ahmad
% @Date:   2020-10-07 09:29:17
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-07 09:50:21
-module(mapdata). 
-export([start/0]). 

start() -> 
   M1 = #{name=>john,age=>25},
   M2 = #{name=>zeeshan,age=>34},
   io:fwrite("~w",[M1]).