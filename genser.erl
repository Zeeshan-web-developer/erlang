% @Author: Zeeshan  Ahmad
% @Date:   2020-09-23 09:52:58
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-23 17:53:54
-module(genser).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([add_num/2,get_num/1,get_all_emp_data/0,update_emp/2,delete_emp/1]).
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]). % this starts the Gen server

stop() ->
  gen_server:cast(?MODULE, stop).       % this stops the gen server
  
add_num(EmpNo,Location) ->
  gen_server:call(?MODULE,{add_num,{EmpNo,Location}}).

get_num(EmpNo) ->
  gen_server:call(?MODULE,{get_num,EmpNo}).

get_all_emp_data() ->
  gen_server:call(?MODULE,{get_all_emp_data}).

update_emp(EmpNo,Location   ) ->
  gen_server:call(?MODULE,{update_emp,{EmpNo,Location}}).

delete_emp(EmpNo) ->
  gen_server:call(?MODULE,{delete_emp,EmpNo}).

init(_Args) ->
  {ok, []}.

handle_call({add_num,{EmpNo,Location}}, _From, State) ->
  NewState = [{EmpNo,Location}|State],
  io:format("latest emp data: ~p~n",[NewState]),
  {reply, added, NewState};

handle_call({get_num,EmpNo}, _From, State) ->
  Result = lists:keyfind(EmpNo,1,State),
  {reply, Result, State};

handle_call({get_all_emp_data}, _From, State) ->
  {reply, lists:reverse(State), State};

handle_call({update_emp,{EmpNo,Location}}, _From, State) ->
  NewState = lists:keyreplace(EmpNo,1,State,{EmpNo,Location}),
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