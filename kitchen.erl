% @Author: Zeeshan  Ahmad
% @Date:   2020-09-17 12:36:50
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-17 17:54:49

-module(kitchen).
-compile(export_all).

fridge2(FoodList) ->
 receive
 {From, {store, Food}} ->
                        From ! {self(), ok},
                        fridge2([Food|FoodList]);
 {From, {take, Food}} ->
                        case lists:member(Food, FoodList) of
                 true ->
                        From ! {self(), {ok, Food}},
                        fridge2(lists:delete(Food, FoodList));

                    false ->
                         From ! {self(), not_found},
                         fridge2(FoodList)
    end;
 
 terminate ->
            ok
 end.





 This is Generic Program

 % @Author: Zeeshan  Ahmad
% @Date:   2020-09-17 12:53:21
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-17 18:00:14
-module(genserver).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([add_emp/4,get_emp/1,get_all_emp_data/0,update_emp/4,delete_emp/1]).
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).
stop() ->
  gen_server:cast(?MODULE, stop).
add_emp(EmpNo,EmpName,Salary,Location) ->
  gen_server:call(?MODULE,{add_emp,{EmpNo,EmpName,Salary,Location}}).
get_emp(EmpNo) ->
  gen_server:call(?MODULE,{get_emp,EmpNo}).
get_all_emp_data() ->
  gen_server:call(?MODULE,{get_all_emp_data}).
update_emp(EmpNo,EmpName,Salary,Location) ->
  gen_server:call(?MODULE,{update_emp,{EmpNo,EmpName,Salary,Location}}).
delete_emp(EmpNo) ->
  gen_server:call(?MODULE,{delete_emp,EmpNo}).
init(_Args) ->
  {ok, []}.
handle_call({add_emp,{EmpNo,EmpName,Salary,Location}}, _From, State) ->
  NewState = [{EmpNo,EmpName,Salary,Location}|State],
  io:format("latest emp data: ~p~n",[NewState]),
  {reply, added, NewState};
handle_call({get_emp,EmpNo}, _From, State) ->
  Result = lists:keyfind(EmpNo,1,State),
  {reply, Result, State};
handle_call({get_all_emp_data}, _From, State) ->
  {reply, lists:reverse(State), State};
handle_call({update_emp,{EmpNo,EmpName,Salary,Location}}, _From, State) ->
  NewState = lists:keyreplace(EmpNo,1,State,{EmpNo,EmpName,Salary,Location}),
  io:format("updated emp data: ~p~n",[NewState]),
  {reply, updated, NewState};
handle_call({delete_emp,EmpNo}, _From, State) ->
  NewState = lists:keydelete(EmpNo,1,State),
  io:format("updated emp data: ~p~n",[NewState]),
  {reply, deleted, NewState};
handle_call(Message, _From, State) ->
  io:format("received other handle_call message: ~p~n",[Message]),
  {reply, ok, State}.
handle_cast(stop,State) ->
  {stop,normal,State};
handle_cast(Message, State) ->
  io:format("received other handle_cast call : ~p~n",[Message]),
  {noreply,State}.
handle_info(Message, State) ->
  io:format("received handle_info message : ~p~n",[Message]),
  {noreply,State}.
code_change(_OldVer, State, _Extra) ->
  {ok,State}.
terminate(Reason, _State) ->
  io:format("server is terminating with reason :~p~n",[Reason]). 