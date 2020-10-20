% @Author: Zeeshan  Ahmad
% @Date:   2020-10-08 14:48:12
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-08 16:50:13

-module(bank).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2, code_change/3]).
%% Server API
-export([start_link/0, stop/0]).
%% clint API
-export([createAccount/1,depositBalance/2,withdrawBalance/2]).


start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop() ->
  gen_server:cast(?MODULE,stop).


createAccount(Who)->
  gen_server:call(?MODULE, {createAccount, Who}).
depositBalance(Who,Amount)  ->
  gen_server:call(?MODULE, {depositBalance,{Who,Amount}}).
withdrawBalance(Who,Amount) ->
  gen_server:call(?MODULE, {withdrawBalance,{Who, Amount}}).
init([]) ->
  {ok,[]}.

handle_call({createAccount,Who}, _From, Tab) ->
  Z=bankdb:createAccount(Who),
  {reply, Z, Tab};

handle_call({depositBalance,{Who,X}}, _From, Tab) ->
  Z=bankdb:depositBalance(Who,X),
  {reply,Z,Tab};

handle_call({withdrawBalance,{Who,X}}, _From, Tab) ->
  Z=bankdb:withdrawBalance(Who,X),
  {reply,Z,Tab};

handle_call(Message, _From, State) ->
  io:format("received other handle_call message: ~p~n",[Message]),
  {reply, ok, State}.




handle_cast(stop,State) ->
  io:format("SERVER IS STOPPING"),
  {stop,normal,State};

handle_cast(Message, State) ->
  io:format("received other handle_cast call : ~p~n",[Message]),
  {noreply,State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(Reason, _State) ->
  io:format("Stopwatch server is shutting down with Reason: ~p~n",[Reason]),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


