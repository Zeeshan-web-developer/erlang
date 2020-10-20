% @Author: Zeeshan  Ahmad
% @Date:   2020-09-28 09:53:21
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-20 16:09:43
-module(emp_manage).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([add_emp/3,get_emp/1,get_all_emp_data/0,update_emp/3,debit_fun/3,delete_emp/1]).
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).
stop() ->
  gen_server:cast(?MODULE, stop).
add_emp(EmpNo,EmpName,Salary) ->
  gen_server:call(?MODULE,{add_emp,{EmpNo,EmpName,Salary}}).

get_emp(EmpName) ->
  gen_server:call(?MODULE,{get_emp,{EmpName}}).

get_all_emp_data() ->
  gen_server:call(?MODULE,{get_all_emp_data}).

update_emp(EmpNo,EmpName,Salary) ->
  gen_server:call(?MODULE,{update_emp,{EmpNo,EmpName,Salary}}).
  
  debit_fun(EmpNo,EmpName,DebitBalance) ->
    gen_server:call(?MODULE,{debit_fun,{EmpNo,EmpName,DebitBalance}}).
    
delete_emp(EmpNo) ->
  gen_server:call(?MODULE,{delete_emp,EmpNo}).
init([]) ->
  {ok, []}.

handle_call({add_emp,{EmpNo,EmpName,Salary}}, _From, State) ->
  NewState = [{EmpNo,EmpName,Salary}|State],
  io:format("latest emp data: ~p~n",[NewState]),
  {reply, added, NewState};

handle_call({get_emp,{EmpName}}, _From, State) ->
 Result= lists:keyfind(EmpName,2,State),
  {reply, Result, State};

handle_call({get_all_emp_data}, _From, State) ->
  {reply,lists:reverse(State), State};

handle_call({update_emp,{EmpNo,EmpName,Salary}}, _From, State) ->
    {_,_,OldSalary}= lists:keyfind(EmpNo,1,State),
  NewState = lists:keyreplace(EmpNo,1,State,{EmpNo,EmpName,OldSalary+Salary}),
  io:format("SALARY UPDATED: ~p~n",[NewState]),
  {reply, updated, NewState};


  handle_call({debit_fun,{EmpNo,EmpName,DebitBalance}}, _From, State) ->
    {_,_,OldBalance}= lists:keyfind(EmpNo,1,State),
    if 
      OldBalance =< 0 ->
          io:format("INSUFFICINT FUNDS \n"),
        DebitBalance=0;
  
OldBalance > 0 ->
        io:format("the equation has only one root \n")
        %NewState = lists:keyreplace(EmpNo,1,State,{EmpNo,EmpName,OldBalance-DebitBalance})
end,
NewState = lists:keyreplace(EmpNo,1,State,{EmpNo,EmpName,OldBalance-DebitBalance}),
{reply, check, NewState};


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