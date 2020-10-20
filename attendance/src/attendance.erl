% @Author: Zeeshan  Ahmad
%Prorgram DEscriptin:This is small attendance based system
%if you present you have to call markMyAttendece function with id and 1-means present
%otherwise automaticlly marks absent
% @Date:   2020-10-01 12:42:39
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-16 12:19:23
-module(attendance).
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
  {ok,[]}.

handle_call({addNewTeacher,{Tid,Tname,Tdesig,Taddress,IntialAttendance}},_From,State)->
  Reply=attendancedb:addNewTeacher(Tid,Tname,Tdesig,Taddress,IntialAttendance),
  if Reply ==true ->
    io:format("Teacher Information added successfully~n");
    true->
      io:format("There is some error in Insert Query~n")
  end,
  {reply,added,State};


handle_call({markAttendance,{Tid,Attendance}},_From,State) ->
  Reply=attendancedb:markAttendance(Tid,Attendance),
  if Reply ==true ->
    io:format("Welcome ?Attendance Saved Successfully~n");
    true->
      io:format("System Error?Please Try After Sometime~n")
  end,
  {reply,done,State};


handle_call({checkMyAttendance,Tid},_From,State)->
  Reply=attendancedb:checkMyAttendance(Tid),
  A=30-Reply,
  P=30-A,
  io:format("Total No: of Present Days=~p~n",[P]),
  io:format("Total No: of Absent Days Days=~p~n",[A]),
  {reply,data_fetched,State};

handle_call({chekMyEarning,Tid},_From,State)->
  Reply=attendancedb:chekMyEarning(Tid),
  A=30-Reply,
  P=30-A,
  TE=P*500,
  io:format("You Total Earning in this month is=~p~n",[TE]),
  {reply,data_fetched,State};

handle_call({checkAllTeacher}, _From, State) ->
  Reply=attendancedb:checkAllTeacher(),
  io:format("ALL TEACHER DATA~n"),
  io:format("~p",[Reply]),
  {reply, Reply,State};


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



