% @Author: Zeeshan  Ahmad
% @Date:   2020-10-01 12:42:39
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-16 12:19:15
-module(attendancedb).
-export([start_link/0,stop/0]).
-export([addNewTeacher/5,markAttendance/2,checkAllTeacher/0,checkMyAttendance/1,chekMyEarning/1]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).

start_link()->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop()->
  gen_server:cast({?MODULE,stop}).

addNewTeacher(Tid,Tname,Tdesig,Taddress,IntialAttendance)->
  gen_server:call(?MODULE,{addNewTeacher,{Tid,Tname,Tdesig,Taddress,IntialAttendance}}).

markAttendance(Tid,Attendance)->
    gen_server:call(?MODULE,{markAttendance,{Tid,Attendance}}).

checkMyAttendance(Tid)->
        gen_server:call(?MODULE,{checkMyAttendance,Tid}).
chekMyEarning(Tid)->
            gen_server:call(?MODULE,{chekMyEarning,Tid}).
checkAllTeacher() ->
        gen_server:call(?MODULE,{checkAllTeacher}).

init([])->
    ets:new(table,[ordered_set,named_table,{keypos,1}]),
    {ok,0}.

handle_call({addNewTeacher,{Tid,Tname,Tdesig,Taddress,IntialAttendance}},_From,State)->
     K=ets:insert(table,[{Tid,Tname,Tdesig,Taddress,IntialAttendance}]),
    {reply,K,State};

handle_call({markAttendance,{Tid,Attendance}}, _From, State) ->
  LastStatus=ets:lookup_element(table,Tid,5),
     if  Attendance==1 ->
          K = ets:update_element(table, Tid, {5,LastStatus+1});
        true->
            K = ets:update_element(table, Tid, {5,LastStatus-1})
      end,
       {reply, K, State};

handle_call({checkMyAttendance,Tid},_From,State)->
    LastStatus=ets:lookup_element(table,Tid,5),
      {reply, LastStatus, State};

handle_call({chekMyEarning,Tid},_From,State)->
    presentDays=ets:lookup_element(table,Tid,5),
       {reply,presentDays,State};

handle_call({checkAllTeacher}, _From, State) ->
      Reply=ets:tab2list(table),
            {reply,Reply,State};

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



