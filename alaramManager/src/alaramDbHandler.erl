% @Author: Zeeshan  Ahmad
% @Date:   2020-10-14 23:28:48
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-15 15:49:04
-module(alaramDbHandler).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([setNewAlaram/3,checkAlaram/1,checkAlaram1/1,checkAllAlarams/0,removeAlaram/1]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE,[],[]).
stop() ->
  gen_server:cast(?MODULE, stop).

setNewAlaram(Time,Message,Status) ->
  gen_server:call(?MODULE, {setNewAlaram,{Time,Message,Status}}).
checkAlaram(Time) ->
  gen_server:call(?MODULE, {checkAlaram,Time}).
checkAlaram1(Time) ->
  gen_server:call(?MODULE, {checkAlaram1,Time}).
checkAllAlarams() ->
  gen_server:call(?MODULE, {checkAllAlarams}).
removeAlaram(Time) ->
  gen_server:call(?MODULE, {removeAlaram, Time}).
init(_Args) ->
  ets:new(table,[ordered_set,named_table,{keypos,1}]),
  {ok, []}.

handle_call({setNewAlaram, {Time,Message,Status}}, _From, _State) ->
  Newstate = ets:insert(table,[{Time,Message,Status}]),
  Result = ets:lookup(table, Time),
  io:format("~nNew Alaram Time Saved Is As~p~n",[Result]),
  {reply,ok, Newstate};
handle_call({checkAlaram, Time}, _From, State) ->
  Result = ets:lookup(table,Time),
  {reply, Result, State};
handle_call({checkAlaram1, Time}, _From, State) ->
  Res1=ets:lookup_element(table, Time, 1),
  {reply, Res1, State};
handle_call({checkAllAlarams}, _From, State) ->
  All = ets:tab2list(table),
  {reply, All, State};
handle_call({removeAlaram, Time}, _From, State) ->
  ets:delete(table, Time),
  {reply,success, State};

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
